local _, ns = ...

local e = ns.unitframes.elements

local function getGroupMemberCounts()
	local memberCounts = {}
	local maxGroupSize = 0

	for i = 1, GetNumGroupMembers() do
		local _, _, subgroup = GetRaidRosterInfo(i)
		if subgroup then
			memberCounts[subgroup] = (memberCounts[subgroup] or 0) + 1
			if memberCounts[subgroup] > maxGroupSize then maxGroupSize = memberCounts[subgroup] end
		end
	end

	-- Solo or party: GetRaidRosterInfo only works in raids,
	-- but all players are effectively in group 1
	-- Solo or party: GetRaidRosterInfo only works in raids,
	-- but all players are effectively in group 1
	if not next(memberCounts) then
		local n = GetNumGroupMembers()
		maxGroupSize = math.max(n, 1)
		memberCounts[1] = maxGroupSize
	end

	return memberCounts, maxGroupSize
end

local UNIT_WIDTH = 120
local UNIT_HEIGHT = 60
local PET_HEIGHT = 30
local GROUP_SPACING = 4
local UNIT_SPACING = 4
local UNITS_PER_GROUP = 5

-- spellId = showInCombat
local buffWhitelists = {
	DRUID = {
		[2893] = true, -- Abolish Poison
		[29166] = true, -- Innervate
		[26992] = false, -- Thorns
		[26991] = false, -- Gift of the Wild
		[26990] = false, -- Mark of the Wild
		[33763] = true, -- Lifebloom
		[26980] = true, -- Regrowth
		[26982] = true, -- Rejuvenation
		[26983] = true, -- Tranquility
	},
}

local _, playerClass = UnitClass('player')
local buffWhitelist = buffWhitelists[playerClass]

local function buffFilter(
	name,
	texture,
	count,
	debuffType,
	duration,
	expirationTime,
	caster,
	isStealable,
	nameplateShowPersonal,
	spellId
)
	if caster ~= 'player' then return false end

	if buffWhitelist then
		local entry = buffWhitelist[spellId]
		if entry == nil then return false end
		if InCombatLockdown() and not entry then return false end
		return true
	end

	-- Default: short buffs (<=5min) always show, long/permanent buffs only out of combat
	if duration and duration > 0 and duration <= 300 then return true end
	return not InCombatLockdown()
end

local function petStyle(f)
	local healthbar, healthbarBar = e.healthbar(f)
	healthbar:SetAllPoints()

	local name = e.nameText(f, healthbarBar, { maxLength = 6 })
	name:SetPoint('BOTTOM', 0, 4)

	local buffs = e.auras(f, 'HELPFUL', { initialAnchor = 'TOPRIGHT', growthX = 'LEFT', filter = buffFilter })
	buffs:SetPoint('TOPRIGHT', healthbarBar, 'TOPRIGHT', -1, -1)

	local marker = e.raidmarker(f, healthbarBar, { size = 14 })
	marker:SetPoint('BOTTOMRIGHT', healthbarBar, 'BOTTOMRIGHT', -4, 4)

	e.range(f)
end

local function style(f)
	local powerbar = e.powerbar(f)
	powerbar:SetPoint('BOTTOMLEFT')
	powerbar:SetPoint('BOTTOMRIGHT')
	powerbar:SetHeight(6)

	local healthbar, healthbarBar = e.healthbar(f)
	healthbar:SetPoint('TOPLEFT')
	healthbar:SetPoint('BOTTOMRIGHT', powerbar, 'TOPRIGHT', 0, -1)

	local name = e.nameText(f, healthbarBar, { maxLength = 6 })
	name:SetPoint('BOTTOM', 0, 4)

	local buffs = e.auras(f, 'HELPFUL', { initialAnchor = 'TOPRIGHT', growthX = 'LEFT', filter = buffFilter })
	buffs:SetPoint('TOPRIGHT', healthbarBar, 'TOPRIGHT', -1, -1)
	local debuffs = e.auras(f, 'HARMFUL', { initialAnchor = 'TOPLEFT' })
	debuffs:SetPoint('TOPLEFT', healthbarBar, 'TOPLEFT', 1, -1)

	local marker = e.raidmarker(f, healthbarBar, { size = 16 })
	marker:SetPoint('BOTTOMRIGHT', healthbarBar, 'BOTTOMRIGHT', -4, 4)

	e.threat(f, { parent = healthbarBar })
	e.selection(f)
	e.range(f)
end

table.insert(ns.unitframes.units, function()
	local container = CreateFrame('Frame', 'AelUIRaidFrame', AelUIParent)
	container:SetPoint('TOP', AelUIPrimaryAnchor, 'BOTTOM', 0, -80)

	local headers = {}
	for i = 1, MAX_RAID_GROUPS do
		headers[i] = ns.unitframes.spawnHeader(
			'AelUIRaidGroup' .. i .. 'Header',
			{
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
			},
			style,
			{
				parent = container,
				secureSetup = ([[
				self:SetWidth(%d)
				self:SetHeight(%d)
			]]):format(UNIT_WIDTH, UNIT_HEIGHT),
			}
		)
	end

	local petHeader = ns.unitframes.spawnHeader(
		'AelUIRaidPetHeader',
		{
			showSolo = true,
			showRaid = true,
			showParty = true,
			showPlayer = true,
			sortMethod = 'INDEX',
			maxColumns = 1,
			unitsPerColumn = UNITS_PER_GROUP,
			point = 'LEFT',
			xOffset = UNIT_SPACING,
		},
		petStyle,
		{
			parent = container,
			template = 'SecureGroupPetHeaderTemplate',
			secureSetup = ([[
				self:SetWidth(%d)
				self:SetHeight(%d)
			]]):format(UNIT_WIDTH, PET_HEIGHT),
		}
	)

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
		if not shouldUpdate then return end

		hasPendingUpdate = false

		local memberCounts, maxGroupSize = getGroupMemberCounts()
		local visibleCount = 0

		for i = 1, MAX_RAID_GROUPS do
			local header = headers[i]
			header:ClearAllPoints()

			if memberCounts[i] then
				header:SetPoint('TOPLEFT', container, 'TOPLEFT', 0, -visibleCount * (UNIT_HEIGHT + GROUP_SPACING))
				visibleCount = visibleCount + 1
			end
		end

		petHeader:ClearAllPoints()
		petHeader:SetPoint('TOPLEFT', container, 'TOPLEFT', 0, -visibleCount * (UNIT_HEIGHT + GROUP_SPACING))

		local contentHeight = visibleCount * UNIT_HEIGHT + math.max(0, visibleCount - 1) * GROUP_SPACING
		contentHeight = contentHeight + GROUP_SPACING + PET_HEIGHT

		container:SetWidth(maxGroupSize * UNIT_WIDTH + math.max(0, maxGroupSize - 1) * UNIT_SPACING)
		container:SetHeight(math.max(1, contentHeight))
	end

	local f = CreateFrame('Frame')
	f:RegisterEvent('GROUP_ROSTER_UPDATE')
	f:RegisterEvent('PLAYER_ENTERING_WORLD')
	f:RegisterEvent('PLAYER_REGEN_ENABLED')
	f:SetScript('OnEvent', update)

	update()
end)
