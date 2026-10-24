local AelEvents = LibStub('AelEvents-1.0')
local lib = LibStub('AelTrackers-1.0')

local AuraContainers = {}
AuraContainers.__index = AuraContainers

lib.auraContainers = setmetatable({ containers = {} }, AuraContainers)
C_Timer.After(0, function()
	lib.auraContainers:Finalise()
end)

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

	container = CreateFrame('AuraContainer', nil, AelUIParent, 'CustomAuraContainerTemplate')
	container:SetPoint('TOPLEFT', AelUIParent, 'TOPLEFT')
	container:SetSize(1, 1)

	self.containers[unit] = container
	return container
end

function AuraContainers:Finalise()
	for unit, container in pairs(self.containers) do
		container:SetEnabled(true)
		container:SetUnit(unit)
		container:UpdateAllAuras()
	end
end

function AuraContainers:Update()
	for unit, container in pairs(self.containers) do
		container:UpdateAllAuras()
	end
end
