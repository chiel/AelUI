local _, ns = ...

local h = ns.helpers
local m = ns.media

local MAX_ENTRIES = 10
local FRAME_WIDTH = 340
local FRAME_HEIGHT = 28
local ICON_SIZE = FRAME_HEIGHT
local FRAME_SPACING = 4
local BTN_SIZE = 20

local ROLL_TYPE_LABELS = {
	[1] = 'Need',
	[2] = 'Greed',
	[3] = 'Disenchant',
	[0] = 'Pass',
}

local ROLL_TYPE_COLORS = {
	[1] = { 0.2, 1, 0.2 },
	[2] = { 1, 1, 0.2 },
	[3] = { 0.5, 0.5, 1 },
	[0] = { 0.6, 0.6, 0.6 },
}

local CLASS_COLORS = {
	WARRIOR = { 0.78, 0.61, 0.43 },
	PALADIN = { 0.96, 0.55, 0.73 },
	HUNTER = { 0.67, 0.83, 0.45 },
	ROGUE = { 1, 0.96, 0.41 },
	PRIEST = { 1, 1, 1 },
	DEATHKNIGHT = { 0.77, 0.12, 0.23 },
	SHAMAN = { 0, 0.44, 0.87 },
	MAGE = { 0.25, 0.78, 0.92 },
	WARLOCK = { 0.53, 0.53, 0.93 },
	DRUID = { 1, 0.49, 0.04 },
}

local function getClassColor(class)
	return CLASS_COLORS[class] or { 1, 1, 1 }
end

local function getQualityColor(quality)
	return ITEM_QUALITY_COLORS[quality] or ITEM_QUALITY_COLORS[1]
end

-- ============================================================
-- Frame pool
-- ============================================================

local rows = {}
local container
local visible = false

local function createRollCount(parent, texture, yOffset)
	local f = CreateFrame('Frame', nil, parent)
	f:SetSize(BTN_SIZE, BTN_SIZE)

	f.icon = f:CreateTexture(nil, 'ARTWORK')
	f.icon:SetTexture(texture)
	local y = yOffset or 0
	f.icon:SetPoint('TOPLEFT', 0, y)
	f.icon:SetPoint('BOTTOMRIGHT', 0, y)
	f.icon:SetAlpha(0.8)

	f.count = f:CreateFontString(nil, 'OVERLAY')
	f.count:SetFont(m.fonts.bold.file, 12, 'OUTLINE')
	f.count:SetPoint('BOTTOMRIGHT', f, 'BOTTOMRIGHT', 2, 0)
	f.count:SetJustifyH('RIGHT')

	return f
end

local function createRow(index)
	local f = CreateFrame('Frame', nil, container)
	f:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
	f:Hide()
	f:EnableMouse(true)

	-- icon
	f.icon = h.createIcon(f, ICON_SIZE)
	f.icon:SetPoint('LEFT', f, 'LEFT', 0, 0)

	-- item name
	f.name = f:CreateFontString(nil, 'OVERLAY')
	f.name:SetFont(m.fonts.default.file, 14, 'OUTLINE')
	f.name:SetPoint('LEFT', f.icon, 'RIGHT', 6, 0)
	f.name:SetJustifyH('LEFT')
	f.name:SetWordWrap(false)

	-- roll count icons (right-aligned)
	f.passCount = createRollCount(f, [[Interface\RAIDFRAME\ReadyCheck-NotReady]], -1)
	f.greedCount = createRollCount(f, [[Interface\Buttons\UI-GroupLoot-Coin-Up]], -3)
	f.needCount = createRollCount(f, [[Interface\Buttons\UI-GroupLoot-Dice-Up]], -2)

	f.passCount:SetPoint('RIGHT', f, 'RIGHT', -2, 0)
	f.greedCount:SetPoint('RIGHT', f.passCount, 'LEFT', -4, 0)
	f.needCount:SetPoint('RIGHT', f.greedCount, 'LEFT', -4, 0)

	-- constrain name so it doesn't overlap buttons
	f.name:SetPoint('RIGHT', f.needCount, 'LEFT', -6, 0)

	-- tooltip on hover
	f:SetScript('OnEnter', function(self)
		if not self.entry then
			return
		end
		local entry = self.entry
		local qc = getQualityColor(entry.quality)

		GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
		GameTooltip:ClearLines()
		GameTooltip:AddLine(entry.itemName, qc.r, qc.g, qc.b)
		GameTooltip:AddLine(' ')

		local grouped = {}
		for _, rollType in ipairs({ 1, 2, 3, 0 }) do
			grouped[rollType] = {}
		end
		for _, r in ipairs(entry.rolls) do
			if grouped[r.rollType] then
				table.insert(grouped[r.rollType], r)
			end
		end

		for _, rollType in ipairs({ 1, 2, 3, 0 }) do
			local players = grouped[rollType]
			if #players > 0 then
				local rc = ROLL_TYPE_COLORS[rollType]
				GameTooltip:AddLine(ROLL_TYPE_LABELS[rollType], rc[1], rc[2], rc[3])
				for _, r in ipairs(players) do
					local cc = getClassColor(r.class)
					local rollStr = r.roll and (' - ' .. r.roll) or ''
					local winStr = r.isWinner and ' *' or ''
					GameTooltip:AddLine('  ' .. r.name .. rollStr .. winStr, cc[1], cc[2], cc[3])
				end
			end
		end

		GameTooltip:Show()
	end)
	f:SetScript('OnLeave', function()
		GameTooltip:Hide()
	end)

	return f
end

local function applyEntry(row, entry)
	row.entry = entry
	local qc = getQualityColor(entry.quality)

	row.icon.texture:SetTexture(entry.texture)
	row.name:SetText(entry.itemName)
	row.name:SetTextColor(qc.r, qc.g, qc.b)

	-- roll counts
	local counts = { [1] = 0, [2] = 0, [0] = 0 }
	for _, r in ipairs(entry.rolls) do
		if counts[r.rollType] then
			counts[r.rollType] = counts[r.rollType] + 1
		end
	end
	row.needCount.count:SetText(counts[1] > 0 and counts[1] or '')
	row.greedCount.count:SetText(counts[2] > 0 and counts[2] or '')
	row.passCount.count:SetText(counts[0] > 0 and counts[0] or '')

	row:Show()
end

-- ============================================================
-- Render
-- ============================================================

local function render()
	if not visible or not ns.db then
		return
	end

	local log = ns.db.global.lootLog
	if not log then
		return
	end

	local count = math.min(#log, MAX_ENTRIES)
	for i = 1, count do
		if not rows[i] then
			rows[i] = createRow(i)
		end
		local row = rows[i]
		row:ClearAllPoints()
		row:SetPoint('TOPLEFT', container, 'TOPLEFT', 0, -(i - 1) * (FRAME_HEIGHT + FRAME_SPACING))
		applyEntry(row, log[i])
	end

	for i = count + 1, #rows do
		rows[i]:Hide()
	end

	container:SetSize(FRAME_WIDTH, count * FRAME_HEIGHT + (count - 1) * FRAME_SPACING)
end

-- ============================================================
-- Toggle
-- ============================================================

container = CreateFrame('Frame', 'AelUILootLog', AelUIParent)
container:SetPoint('LEFT', AelUIParent, 'LEFT', 20, 0)
container:Hide()

local function toggle()
	visible = not visible
	if visible then
		container:Show()
		render()
	else
		container:Hide()
	end
end

ns.lootlog = {
	show = toggle,
	render = render,
}
