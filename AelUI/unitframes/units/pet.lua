local _, ns = ...

local e = ns.unitframes.elements

ns.unitframes.units.spawn('pet', function(f)
	f:SetSize(175, 42)
	f:SetPoint('TOPLEFT', AelUIPlayerFrame, 'BOTTOMLEFT', 0, -2)

	local healthbar, healthbarBar = e.healthbar(f)
	healthbar:SetAllPoints()

	local name = e.nameText(f, healthbarBar)
	name:SetPoint('BOTTOMLEFT', healthbar, 'BOTTOMLEFT', 6, 0)
end)
