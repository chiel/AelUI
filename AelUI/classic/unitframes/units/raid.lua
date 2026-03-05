local _, ns = ...

local e = ns.unitframes.elements

local function getVisibleGroups()
	local visibleGroups = {}

	for i = 1, GetNumGroupMembers() do
		local _, _, subgroup = GetRaidRosterInfo(i)
		if subgroup then
			visibleGroups[subgroup] = true
		end
	end

	-- Solo or party: GetRaidRosterInfo only works in raids,
	-- but all players are effectively in group 1
	if not next(visibleGroups) then
		visibleGroups[1] = true
	end

	return visibleGroups
end

local UNIT_WIDTH = 60
local UNIT_HEIGHT = 60
local GROUP_SPACING = 4
local UNIT_SPACING = 4
local UNITS_PER_GROUP = 5

local ROW_WIDTH = UNITS_PER_GROUP * UNIT_WIDTH + (UNITS_PER_GROUP - 1) * UNIT_SPACING

local function style(f)
	f:SetSize(UNIT_WIDTH, UNIT_HEIGHT)

	local healthbar, healthbarBar = e.healthbar(f, { orientation = 'VERTICAL' })
	healthbar:SetAllPoints()

	local name = e.nameText(f, healthbarBar, { maxLength = 3 })
	name:SetPoint('BOTTOM', 0, 4)

	e.range(f)
end

table.insert(ns.unitframes.units, function()
	local container = CreateFrame('Frame', 'AelUIRaidFrame', AelUIParent)
	container:SetPoint('TOPRIGHT', AelUIPrimaryAnchor, 'BOTTOMLEFT', -300, -200)

	local headers = {}
	for i = 1, MAX_RAID_GROUPS do
		headers[i] = ns.unitframes.spawnHeader('AelUIRaidGroup' .. i .. 'Header', {
			showSolo = true,
			showRaid = true,
			showParty = true,
			showPlayer = true,
			groupFilter = tostring(i),
			sortMethod = 'INDEX',
			maxColumns = 1,
			unitsPerColumn = UNITS_PER_GROUP,
			point = 'LEFT',
			xOffset = UNIT_SPACING,
		}, style, container)
	end

	local hasPendingUpdate = false

	local function update(self, event)
		if InCombatLockdown() then
			hasPendingUpdate = true
			return
		end

		local shouldUpdate = event == nil
			or event == 'GROUP_ROSTER_UPDATE'
			or event == 'PLAYER_ENTERING_WORLD'
			or hasPendingUpdate
		if not shouldUpdate then
			return
		end

		hasPendingUpdate = false

		local visibleGroups = getVisibleGroups()
		local visibleCount = 0

		for i = 1, MAX_RAID_GROUPS do
			local header = headers[i]
			header:ClearAllPoints()

			if visibleGroups[i] then
				header:SetPoint('TOPLEFT', container, 'TOPLEFT', 0, -visibleCount * (UNIT_HEIGHT + GROUP_SPACING))
				visibleCount = visibleCount + 1
			end
		end

		container:SetWidth(ROW_WIDTH)
		container:SetHeight(math.max(1, visibleCount * UNIT_HEIGHT + math.max(0, visibleCount - 1) * GROUP_SPACING))
	end

	local f = CreateFrame('Frame')
	f:RegisterEvent('GROUP_ROSTER_UPDATE')
	f:RegisterEvent('PLAYER_ENTERING_WORLD')
	f:RegisterEvent('PLAYER_REGEN_ENABLED')
	f:SetScript('OnEvent', update)

	update()
end)
