local _, ns = ...

local e = ns.unitframes.elements

ns.unitframes.units.spawn('targettarget', function(f)
	f:SetSize(175, 42)
	f:SetPoint('TOPRIGHT', AelUITargetFrame, 'BOTTOMRIGHT', 0, -2)

	local healthbar, healthbarBar = e.healthbar(f)
	healthbar:SetAllPoints()

	local name = e.nameText(f, healthbarBar)
	name:SetPoint('BOTTOMRIGHT', healthbar, 'BOTTOMRIGHT', -6, 0)
end)
