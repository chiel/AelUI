local _, ns = ...

local e = ns.unitframes.elements
local m = ns.media
local u = ns.utils

ns.unitframes.units.spawn('target', function(f)
	f:SetSize(300, 60)
	f:SetPoint('TOPLEFT', AelUIPrimaryAnchor, 'TOPRIGHT', 20, 0)

	local healthbar = e.healthbar(f)
	healthbar:SetAllPoints()
end)
