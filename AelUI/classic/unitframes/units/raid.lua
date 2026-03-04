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

local function style(f)
	f:SetSize(40, 40)

	local bg = f:CreateTexture(nil, 'BACKGROUND')
	bg:SetAllPoints()
	bg:SetColorTexture(0.2, 0.2, 0.2, 1)

	f.Update = function(self)
		local _, class = UnitClass(self.unit)
		if class then
			local c = RAID_CLASS_COLORS[class]
			if c then
				bg:SetColorTexture(c.r, c.g, c.b, 1)
				return
			end
		end
		bg:SetColorTexture(0.2, 0.2, 0.2, 1)
	end

	e.range(f)

	f:Update()
end

local UNIT_WIDTH = 40
local UNIT_HEIGHT = 40
local GROUP_SPACING = 4
local UNIT_SPACING = 4
local UNITS_PER_GROUP = 5
local COLUMN_HEIGHT = UNITS_PER_GROUP * UNIT_HEIGHT + (UNITS_PER_GROUP - 1) * UNIT_SPACING

table.insert(ns.unitframes.units, function()
	local container = CreateFrame('Frame', 'AelUIRaidFrame', AelUIParent)
	container:SetPoint('TOPLEFT', AelUIParent, 'TOPLEFT', 300, -240)
	container:SetHeight(COLUMN_HEIGHT)

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
			point = 'TOP',
			yOffset = -UNIT_SPACING,
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
				header:SetPoint('TOPLEFT', container, 'TOPLEFT', visibleCount * (UNIT_WIDTH + GROUP_SPACING), 0)
				visibleCount = visibleCount + 1
			end
		end

		local width = math.max(1, visibleCount * UNIT_WIDTH + math.max(0, visibleCount - 1) * GROUP_SPACING)
		container:SetWidth(width)
	end

	local f = CreateFrame('Frame')
	f:RegisterEvent('GROUP_ROSTER_UPDATE')
	f:RegisterEvent('PLAYER_ENTERING_WORLD')
	f:RegisterEvent('PLAYER_REGEN_ENABLED')
	f:SetScript('OnEvent', update)

	update()
end)
