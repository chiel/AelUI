local AelEvents = LibStub('AelEvents-1.0')
local lib = LibStub('AelTrackers-1.0')

local AuraContainers = {}
AuraContainers.__index = AuraContainers

lib.auraContainers = setmetatable({ containers = {} }, AuraContainers)

AelEvents.on('PLAYER_TARGET_CHANGED', function()
	lib.auraContainers:Update()
end)

function AuraContainers:Get(unit)
	local container = self.containers[unit]
	if container then
		return container
	end

	if not C_AddOns.IsAddOnLoaded('Blizzard_AuraContainer') then
		C_AddOns.LoadAddOn('Blizzard_AuraContainer')
	end

	local parent = lib.defaults.parent or UIParent
	container = CreateFrame('AuraContainer', nil, parent, 'CustomAuraContainerTemplate')
	container:SetPoint('TOPLEFT', parent, 'TOPLEFT')
	container:SetSize(1, 1)
	container:SetUnit(unit)
	container:SetEnabled(true)

	self.containers[unit] = container
	return container
end

function AuraContainers:Update()
	for unit, container in pairs(self.containers) do
		container:UpdateAllAuras()
	end
end
