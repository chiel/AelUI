local _, ns = ...

local AelEvents = LibStub('AelEvents-1.0')
local h = ns.fishing.helpers

local angler = ns.fishing.createAngler()
angler:SetPoint('BOTTOMRIGHT', AelUIPrimaryAnchor, 'TOPLEFT', -20, 80)

AelEvents.on('BAG_UPDATE', function()
	if h.hasFishingPole() then
		angler:UpdateLures()
	end
end)

AelEvents.on('PLAYER_ENTERING_WORLD', function()
	if h.hasFishingPole() then
		angler:Enable()
	end
end)

AelEvents.on('PLAYER_EQUIPMENT_CHANGED', function(_, slotId)
	if slotId ~= 16 then
		return
	end

	if h.hasFishingPole() then
		angler:Enable()
	else
		angler:Disable()
	end
end)
