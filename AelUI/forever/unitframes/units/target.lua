local _, ns = ...

local e = ns.unitframes.elements

ns.unitframes.units.spawn('target', function(f)
	f:SetSize(300, 60)
	f:SetPoint('TOPLEFT', AelUIPrimaryAnchor, 'TOPRIGHT', 20, 0)

	local healthbar, healthbarBar = e.healthbar(f)
	healthbar:SetAllPoints()

	local name = e.nameText(f, healthbarBar, { fontSize = 24 })
	name:SetPoint('BOTTOMRIGHT', healthbar, 'BOTTOMRIGHT', -6, 0)

	local hpPct = e.healthPercentText(f, healthbarBar, { fontSize = 20 })
	hpPct:SetPoint('BOTTOMLEFT', healthbar, 'BOTTOMLEFT', 4, 0)

	local hpCur = e.healthCurrentText(f, healthbarBar, { fontSize = 16 })
	hpCur:SetPoint('BOTTOMLEFT', hpPct, 'TOPLEFT', 0, 0)

	local leaderIcon = e.leaderIcon(f, healthbarBar)
	leaderIcon:SetPoint('TOPLEFT', 4, 0)
	leaderIcon:SetSize(24, 24)

	local castbar = e.castbar(f)
	castbar:SetPoint('BOTTOMLEFT', AelUIPrimaryAnchor, 'TOPLEFT', 0, 60)
	castbar:SetPoint('BOTTOMRIGHT', AelUIPrimaryAnchor, 'TOPRIGHT', 0, 60)
	castbar:SetHeight(8)
end)
