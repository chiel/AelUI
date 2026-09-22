local _, ns = ...

local e = ns.unitframes.elements

ns.unitframes.units.spawn('player', function(f)
	f:SetSize(300, 58)
	f:SetPoint('TOPRIGHT', AelUIPrimaryAnchor, 'TOPLEFT', 0, 0)

	local healthbar = e.healthbar(f)
	healthbar:SetAllPoints()
end)
