local _, ns = ...

local e = ns.unitframes.elements

ns.unitframes.units.spawn('player', function(f)
	f:SetSize(300, 58)
	f:SetPoint('TOPRIGHT', AelUIPrimaryAnchor, 'TOPLEFT', -20, 0)

	local healthbar = e.healthbar(f)
	healthbar:SetAllPoints()

	local castbar = e.castbar(f)
	castbar:SetPoint('TOPLEFT', AelUIPrimaryAnchor, 'BOTTOMLEFT', 0, 0)
	castbar:SetPoint('TOPRIGHT', AelUIPrimaryAnchor, 'BOTTOMRIGHT', 0, 0)
	castbar:SetHeight(6)
end)
