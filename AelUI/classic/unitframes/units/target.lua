local _, ns = ...

local e = ns.unitframes.elements
local m = ns.media

table.insert(ns.unitframes.units, function(f)
	local f = ns.unitframes.spawn('target')
	f:SetPoint('TOPLEFT', AelUIPrimaryAnchor, 'TOPRIGHT', 20, 0)
	f:SetSize(350, 58)

	local healthbar, healthbarBar = e.healthbar(f)
	healthbar:SetAllPoints()

	local name = e.nameText(f, healthbarBar, { fontSize = 24 })
	name:SetPoint('BOTTOMRIGHT', healthbar, 'BOTTOMRIGHT', -6, 0)

	local hpPct = e.healthPercent(f, healthbarBar, { fontSize = 20 })
	hpPct:SetPoint('BOTTOMLEFT', healthbar, 'BOTTOMLEFT', 4, 0)

	local hpCur = e.healthCurrent(f, healthbarBar, { fontSize = 16 })
	hpCur:SetPoint('BOTTOMLEFT', hpPct, 'TOPLEFT', 0, 0)

	local pvp = e.pvpText(f, healthbarBar, { fontSize = 14 })
	pvp:SetPoint('BOTTOMRIGHT', name, 'BOTTOMLEFT', -8, 3)

	local powerbar = e.powerbar(f)
	powerbar:SetPoint('TOPLEFT', healthbar, 'BOTTOMLEFT', 0, -2)
	powerbar:SetSize(140, 8)

	local debuffs = e.auras(f, 'HARMFUL', {
		cooldownText = true,
		growthX = 'RIGHT',
		iconSize = 40,
		initialAnchor = 'BOTTOMLEFT',
		spacingX = 2,
	})
	debuffs:SetPoint('BOTTOMLEFT', healthbar, 'TOPLEFT', 0, 2)

	local marker = e.raidmarker(f, healthbarBar)
	marker:SetPoint('RIGHT', healthbarBar, 'RIGHT', -4, 0)

	e.range(f)

	return f
end)
