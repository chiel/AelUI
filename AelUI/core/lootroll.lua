local _, ns = ...

local h = ns.helpers
local m = ns.media

local FRAME_WIDTH = 460
local FRAME_HEIGHT = 40
local ICON_SIZE = FRAME_HEIGHT
local BAR_HEIGHT = 14
local FRAME_SPACING = 8
local MAX_ROLLS = 4

local QUALITY_COLORS = {
	[0] = { 0.62, 0.62, 0.62 }, -- Poor
	[1] = { 1, 1, 1 }, -- Common
	[2] = { 0.12, 1, 0 }, -- Uncommon
	[3] = { 0, 0.44, 0.87 }, -- Rare
	[4] = { 0.64, 0.21, 0.93 }, -- Epic
	[5] = { 1, 0.50, 0 }, -- Legendary
}

local ROLL_NEED = 1
local ROLL_GREED = 2
local ROLL_DISENCHANT = 3
local ROLL_PASS = 0

-- pool of roll frames
local frames = {}
-- map rollID -> frame
local active = {}

local anchor = CreateFrame('Frame', 'AelUILootRollAnchor', AelUIParent)
anchor:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
anchor:SetPoint('BOTTOMRIGHT', AelUIPrimaryAnchor, 'TOPLEFT', -200, 120)

local function getQualityColor(quality)
	return QUALITY_COLORS[quality] or QUALITY_COLORS[1]
end

local function createRollButton(parent, texture, size, yOffset)
	local btn = CreateFrame('Button', nil, parent)
	btn:SetSize(size, size)

	btn.icon = btn:CreateTexture(nil, 'ARTWORK')
	btn.icon:SetTexture(texture)
	local y = yOffset or 0
	btn.icon:SetPoint('TOPLEFT', 0, y)
	btn.icon:SetPoint('BOTTOMRIGHT', 0, y)

	btn.count = btn:CreateFontString(nil, 'OVERLAY')
	btn.count:SetFont(m.fonts.bold.file, 14, 'OUTLINE')
	btn.count:SetPoint('BOTTOMRIGHT', btn, 'BOTTOMRIGHT', 2, 0)
	btn.count:SetJustifyH('RIGHT')
	btn.count:SetText('0')

	btn:SetScript('OnEnter', function(self)
		self.icon:SetAlpha(1)
	end)
	btn:SetScript('OnLeave', function(self)
		self.icon:SetAlpha(0.8)
	end)
	btn.icon:SetAlpha(0.8)

	return btn
end

local function createRollFrame(index)
	local f = CreateFrame('Frame', 'AelUILootRoll' .. index, AelUIParent)
	f:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
	f:Hide()

	-- item icon
	local icon = CreateFrame('Frame', nil, f, 'BackdropTemplate')
	icon:SetSize(ICON_SIZE, ICON_SIZE)
	icon:SetPoint('LEFT', f, 'LEFT', 0, 0)
	icon:SetBackdrop({ edgeFile = m.borders.default.file, edgeSize = 1 })
	icon:SetBackdropBorderColor(0, 0, 0, 1)

	icon.texture = icon:CreateTexture(nil, 'ARTWORK')
	icon.texture:SetPoint('TOPLEFT', 1, -1)
	icon.texture:SetPoint('BOTTOMRIGHT', -1, 1)
	icon.texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	f.icon = icon

	-- tooltip on icon hover
	icon:EnableMouse(true)
	icon:SetScript('OnEnter', function(self)
		if f.rollID then
			GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
			GameTooltip:SetLootRollItem(f.rollID)
			GameTooltip:Show()
			GameTooltip_ShowCompareItem()
		end
	end)
	icon:SetScript('OnLeave', function()
		GameTooltip:Hide()
		ShoppingTooltip1:Hide()
		ShoppingTooltip2:Hide()
	end)

	-- timer bar (bottom strip)
	local bar, barBd, barBg = h.createStatusBar(f)
	barBd:SetPoint('BOTTOMLEFT', icon, 'BOTTOMRIGHT', 2, 0)
	barBd:SetPoint('BOTTOMRIGHT', f, 'BOTTOMRIGHT', 0, 0)
	barBd:SetHeight(BAR_HEIGHT)
	bar:SetMinMaxValues(0, 1)
	f.bar = bar
	f.barBd = barBd
	f.barBg = barBg

	-- item name (top-left, above the bar)
	f.name = f:CreateFontString(nil, 'OVERLAY')
	f.name:SetFont(m.fonts.default.file, 18, 'OUTLINE')
	f.name:SetPoint('BOTTOMLEFT', barBd, 'TOPLEFT', 2, 2)
	f.name:SetJustifyH('LEFT')

	-- roll buttons (top row, right-aligned)
	local btnSize = 28
	local btnSpacing = 6

	f.passBtn = createRollButton(f, [[Interface\RAIDFRAME\ReadyCheck-NotReady]], btnSize, -2)
	f.greedBtn = createRollButton(f, [[Interface\Buttons\UI-GroupLoot-Coin-Up]], btnSize, -5)
	f.needBtn = createRollButton(f, [[Interface\Buttons\UI-GroupLoot-Dice-Up]], btnSize, -3)

	-- position buttons from right
	f.passBtn:SetPoint('BOTTOMRIGHT', barBd, 'TOPRIGHT', -2, 0)
	f.greedBtn:SetPoint('RIGHT', f.passBtn, 'LEFT', -btnSpacing, 0)
	f.needBtn:SetPoint('RIGHT', f.greedBtn, 'LEFT', -btnSpacing, 0)

	-- bind text (left of need button)
	f.bind = f:CreateFontString(nil, 'OVERLAY')
	f.bind:SetFont(m.fonts.bold.file, 14, 'OUTLINE')
	f.bind:SetPoint('RIGHT', f.needBtn, 'LEFT', -6, -4)
	f.bind:SetTextColor(0.8, 0.6, 0.6)

	-- click handlers
	f.needBtn:SetScript('OnClick', function()
		if f.rollID then
			RollOnLoot(f.rollID, ROLL_NEED)
		end
	end)
	f.greedBtn:SetScript('OnClick', function()
		if f.rollID then
			RollOnLoot(f.rollID, ROLL_GREED)
		end
	end)
	f.passBtn:SetScript('OnClick', function()
		if f.rollID then
			RollOnLoot(f.rollID, ROLL_PASS)
		end
	end)

	-- timer
	f:SetScript('OnUpdate', function(self, elapsed)
		if not self.endTime then
			return
		end
		local remaining = self.endTime - GetTime()
		if remaining <= 0 then
			self.bar:SetValue(0)
			return
		end
		self.bar:SetValue(remaining / self.duration)
	end)

	return f
end

local function getFrame()
	for _, f in ipairs(frames) do
		if not f:IsShown() then
			return f
		end
	end
	if #frames < MAX_ROLLS then
		local f = createRollFrame(#frames + 1)
		table.insert(frames, f)
		return f
	end
	return nil
end

local function layoutFrames()
	local offset = 0
	for _, f in ipairs(frames) do
		if f:IsShown() then
			f:ClearAllPoints()
			f:SetPoint('BOTTOM', anchor, 'BOTTOM', 0, offset)
			offset = offset + FRAME_HEIGHT + FRAME_SPACING
		end
	end
end

local function setupFrame(f, options)
	f.rollID = options.rollID
	f.duration = options.duration
	f.endTime = GetTime() + options.duration

	-- icon
	f.icon.texture:SetTexture(options.texture)
	local color = getQualityColor(options.quality)

	-- name (white for readability)
	f.name:SetText(options.name)
	f.name:SetTextColor(1, 1, 1)

	-- bind
	f.bind:SetText(options.bindOnPickUp and 'BoP' or 'BoE')

	-- bar color (quality color)
	f.bar:GetStatusBarTexture():SetVertexColor(color[1] * 0.6, color[2] * 0.6, color[3] * 0.6)
	f.barBg:SetVertexColor(color[1] * 0.15, color[2] * 0.15, color[3] * 0.15)
	f.bar:SetValue(1)

	-- buttons (fade if unavailable)
	local canNeed = options.canNeed ~= false
	f.needBtn:SetAlpha(canNeed and 1 or 0.3)
	f.needBtn:EnableMouse(canNeed)
	f.greedBtn:SetShown(options.canGreed ~= false)

	f.needBtn.count:SetText('0')
	f.greedBtn.count:SetText('0')
	f.passBtn.count:SetText('0')

	f:Show()
	layoutFrames()
end

local function startRoll(rollID, rollTime)
	local f = getFrame()
	if not f then
		return
	end

	local texture, name, count, quality, bindOnPickUp, canNeed, canGreed, canDisenchant = GetLootRollItemInfo(rollID)

	setupFrame(f, {
		rollID = rollID,
		duration = rollTime / 1000,
		texture = texture,
		name = name,
		quality = quality,
		bindOnPickUp = bindOnPickUp,
		canNeed = canNeed,
		canGreed = canGreed,
	})

	active[rollID] = f
end

local function cancelRoll(rollID)
	local f = active[rollID]
	if not f then
		return
	end

	f.rollID = nil
	f.endTime = nil
	active[rollID] = nil
	f:Hide()
	layoutFrames()
end

-- disable default loot roll frames
for i = 1, NUM_GROUP_LOOT_FRAMES do
	local f = _G['GroupLootFrame' .. i]
	f:UnregisterAllEvents()
	f:Hide()
end

-- event handler
local handler = CreateFrame('Frame')
handler:RegisterEvent('START_LOOT_ROLL')
handler:RegisterEvent('CANCEL_LOOT_ROLL')
handler:SetScript('OnEvent', function(self, event, rollID, rollTime)
	if event == 'START_LOOT_ROLL' then
		startRoll(rollID, rollTime)
	elseif event == 'CANCEL_LOOT_ROLL' then
		cancelRoll(rollID)
	end
end)
