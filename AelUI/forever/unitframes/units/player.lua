local _, ns = ...

local e = ns.unitframes.elements

ns.unitframes.units.spawn('player', function(f)
	f:SetSize(300, 58)
	f:SetPoint('TOPRIGHT', AelUIPrimaryAnchor, 'TOPLEFT', -20, 0)

	local healthbar, healthbarBar = e.healthbar(f)
	healthbar:SetAllPoints()

	local powerbar = e.powerbar(f)
	powerbar:SetPoint('BOTTOMLEFT', AelUIPrimaryAnchor, 'TOPLEFT', 0, 2)
	powerbar:SetPoint('BOTTOMRIGHT', AelUIPrimaryAnchor, 'TOPRIGHT', 0, 2)
	powerbar:SetHeight(16)

	local castbar = e.castbar(f)
	castbar:SetPoint('TOPLEFT', AelUIPrimaryAnchor, 'BOTTOMLEFT', 0, 0)
	castbar:SetPoint('TOPRIGHT', AelUIPrimaryAnchor, 'BOTTOMRIGHT', 0, 0)
	castbar:SetHeight(6)

	local hpPct = e.healthPercentText(f, healthbarBar, { fontSize = 20 })
	hpPct:SetPoint('BOTTOMRIGHT', healthbar, 'BOTTOMRIGHT', -4, 0)

	local hpCur = e.healthCurrentText(f, healthbarBar, { fontSize = 16 })
	hpCur:SetPoint('BOTTOMRIGHT', hpPct, 'TOPRIGHT', 0, 0)
end)
