local _, ns = ...

local h = ns.helpers
local m = ns.media

local FRAME_WIDTH = 460
local FRAME_HEIGHT = 40
local ICON_SIZE = FRAME_HEIGHT
local BAR_HEIGHT = 14
local FRAME_SPACING = 8
local GROWTH_DIRECTION = 'UP' -- 'UP' or 'DOWN'

local ROLL_NEED = 1
local ROLL_GREED = 2
local ROLL_PASS = 0

local ROLL_TYPE_BUTTONS = {
	[ROLL_NEED] = 'needBtn',
	[ROLL_GREED] = 'greedBtn',
	[ROLL_PASS] = 'passBtn',
}

local pool = {} -- frames available for reuse (rollID == nil)
local activeFrames = {} -- frames currently displaying a roll
local frameCount = 0 -- total frames ever created, for naming

local container = CreateFrame('Frame', 'AelUILootRollContainer', AelUIParent)
container:SetPoint('BOTTOMRIGHT', AelUIPrimaryAnchor, 'TOPLEFT', -200, 120)
container:SetWidth(FRAME_WIDTH)

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

local function createRollFrame()
	frameCount = frameCount + 1
	local f = CreateFrame('Frame', 'AelUILootRoll' .. frameCount, container)
	f:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
	f:Hide()

	f.icon = h.createIcon(f, ICON_SIZE)
	f.icon:SetPoint('LEFT', f, 'LEFT', 0, 0)
	local icon = f.icon

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

	local bar, barBd, barBg = h.createStatusBar(f)
	barBd:SetPoint('BOTTOMLEFT', icon, 'BOTTOMRIGHT', 2, 0)
	barBd:SetPoint('BOTTOMRIGHT', f, 'BOTTOMRIGHT', 0, 0)
	barBd:SetHeight(BAR_HEIGHT)
	bar:SetMinMaxValues(0, 1)
	f.bar = bar
	f.barBd = barBd
	f.barBg = barBg

	f.name = f:CreateFontString(nil, 'OVERLAY')
	f.name:SetFont(m.fonts.default.file, 18, 'OUTLINE')
	f.name:SetPoint('BOTTOMLEFT', barBd, 'TOPLEFT', 2, 2)
	f.name:SetJustifyH('LEFT')

	local btnSize = 28
	local btnSpacing = 6

	f.passBtn = createRollButton(f, [[Interface\RAIDFRAME\ReadyCheck-NotReady]], btnSize, -2)
	f.greedBtn = createRollButton(f, [[Interface\Buttons\UI-GroupLoot-Coin-Up]], btnSize, -5)
	f.needBtn = createRollButton(f, [[Interface\Buttons\UI-GroupLoot-Dice-Up]], btnSize, -3)

	f.passBtn:SetPoint('BOTTOMRIGHT', barBd, 'TOPRIGHT', -2, 0)
	f.greedBtn:SetPoint('RIGHT', f.passBtn, 'LEFT', -btnSpacing, 0)
	f.needBtn:SetPoint('RIGHT', f.greedBtn, 'LEFT', -btnSpacing, 0)

	f.bind = f:CreateFontString(nil, 'OVERLAY')
	f.bind:SetFont(m.fonts.bold.file, 14, 'OUTLINE')
	f.bind:SetPoint('RIGHT', f.needBtn, 'LEFT', -6, -4)
	f.bind:SetTextColor(0.8, 0.6, 0.6)

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

	f:SetScript('OnUpdate', function(self)
		if not self.rollID then
			return
		end
		local remaining = GetLootRollTimeLeft(self.rollID)
		if remaining <= 0 then
			self.bar:SetValue(0)
			return
		end
		self.bar:SetValue(remaining / (ns.lootrolls.rolls[self.rollID].duration * 1000))
	end)

	return f
end

local function getFrame(rollID)
	local f = activeFrames[rollID] or table.remove(pool, 1) or createRollFrame()
	activeFrames[rollID] = f
	return f
end

local function releaseFrame(rollID)
	local f = activeFrames[rollID]
	if not f then
		return
	end

	f:Hide()
	f.rollID = nil
	activeFrames[rollID] = nil
	table.insert(pool, f)
end

local function applyToFrame(f, roll)
	f.rollID = roll.rollID

	f.icon.texture:SetTexture(roll.texture)
	f.name:SetText(roll.name)
	f.name:SetTextColor(1, 1, 1)
	f.bind:SetText(roll.bindOnPickUp and 'BoP' or 'BoE')

	local color = ITEM_QUALITY_COLORS[roll.quality] or ITEM_QUALITY_COLORS[1]
	f.bar:GetStatusBarTexture():SetVertexColor(color.r * 0.6, color.g * 0.6, color.b * 0.6)
	f.barBg:SetVertexColor(color.r * 0.15, color.g * 0.15, color.b * 0.15)
	f.bar:SetValue(1)

	local canNeed = roll.canNeed ~= false
	f.needBtn:SetAlpha(canNeed and 1 or 0.3)
	f.needBtn:EnableMouse(canNeed)
	f.greedBtn:SetShown(roll.canGreed ~= false)

	local counts = { [ROLL_NEED] = 0, [ROLL_GREED] = 0, [ROLL_PASS] = 0 }
	for _, p in ipairs(roll.players) do
		if counts[p.rollType] then
			counts[p.rollType] = counts[p.rollType] + 1
		end
	end
	for rollType, btnKey in pairs(ROLL_TYPE_BUTTONS) do
		f[btnKey].count:SetText(counts[rollType])
	end
end

ns.lootrolls.render = function(rolls)
	-- prune frames for dismissed/gone rolls back to pool
	for rollID, _ in pairs(activeFrames) do
		local roll = rolls[rollID]
		if not roll or roll.dismissed then
			releaseFrame(rollID)
		end
	end

	-- sort active rolls
	local activeRolls = {}
	for _, roll in pairs(rolls) do
		if not roll.dismissed then
			table.insert(activeRolls, roll)
		end
	end
	table.sort(activeRolls, function(a, b)
		return a.startTime < b.startTime
	end)

	-- apply and position
	local count = #activeRolls
	container:SetHeight(math.max(0, count * FRAME_HEIGHT + (count - 1) * FRAME_SPACING))

	for i, roll in ipairs(activeRolls) do
		local f = getFrame(roll.rollID)
		applyToFrame(f, roll)
		f:Show()
		f:ClearAllPoints()
		if GROWTH_DIRECTION == 'UP' then
			f:SetPoint('BOTTOMLEFT', container, 'BOTTOMLEFT', 0, (i - 1) * (FRAME_HEIGHT + FRAME_SPACING))
		else
			f:SetPoint('TOPLEFT', container, 'TOPLEFT', 0, -(i - 1) * (FRAME_HEIGHT + FRAME_SPACING))
		end
	end
end
