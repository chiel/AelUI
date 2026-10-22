local _, ns = ...

local AelEvents = LibStub('AelEvents-1.0')

local e = ns.unitframes.elements
local h = ns.unitframes.helpers

local _, playerClass = UnitClass('player')

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

	e.range(f)
end

local layout = h.getRaidLayout()
local container = CreateFrame('Frame', 'AelUIRaidFrame', AelUIParent)
container:SetPoint('TOP', AelUIPrimaryAnchor, 'BOTTOM', 0, -80)
container:SetSize(layout.containerWidth, layout.containerHeight)

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
			point = layout.point,
			xOffset = layout.xOffset,
			yOffset = layout.yOffset,
		},
		style,
		{
			parent = container,
			secureSetup = ([[
				self:SetWidth(%d)
				self:SetHeight(%d)
			]]):format(layout.unitWidth, layout.unitHeight),
		}
	)
end

local hasPendingUpdate = false

local function update(event)
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

	local l = h.getRaidLayout()
	if not l then
		return
	end

	local groupIndex = 0
	for i = 1, MAX_RAID_GROUPS do
		local header = headers[i]
		header:Hide()

		header:SetAttribute(
			'aelUI-secureSetup',
			([[
				self:SetWidth(%d)
				self:SetHeight(%d)
			]]):format(l.unitWidth, l.unitHeight)
		)

		if l.memberCounts[i] then
			header:ClearAllPoints()

			local i = 1
			local child = header:GetAttribute('child' .. i)
			while child do
				child:ClearAllPoints()
				child:SetSize(l.unitWidth, l.unitHeight)
				i = i + 1
				child = header:GetAttribute('child' .. i)
			end

			if l.point ~= header:GetAttribute('point') then
				header:SetAttribute('point', l.point)
				header:SetAttribute('xOffset', l.xOffset)
				header:SetAttribute('yOffset', l.yOffset)
			end

			if l.groupAxis == 'y' then
				header:SetPoint('TOPLEFT', container, 'TOPLEFT', 0, -groupIndex * (l.unitHeight + l.ySpacing))
			else
				header:SetPoint('TOPLEFT', container, 'TOPLEFT', groupIndex * (l.unitWidth + l.xSpacing), 0)
			end

			groupIndex = groupIndex + 1
			header:Show()
		end
	end

	container:SetSize(l.containerWidth, l.containerHeight)
end

AelEvents.on('GROUP_ROSTER_UPDATE', update)
AelEvents.on('PLAYER_ENTERING_WORLD', update)
AelEvents.on('PLAYER_REGEN_ENABLED', update)

update()
