local _, ns = ...

local e = ns.unitframes.elements

table.insert(ns.unitframes.units, function()
	local f = ns.unitframes.spawn('targettarget')
	f:SetPoint('TOPRIGHT', AelUITargetFrame, 'BOTTOMRIGHT', 0, -2)
	f:SetSize(175, 30)

	local healthbar, healthbarBar = e.healthbar(f)
	healthbar:SetAllPoints()

	local name = e.nameText(f, healthbarBar, { fontSize = 16 })
	name:SetPoint('BOTTOMRIGHT', healthbar, 'BOTTOMRIGHT', -6, 2)

	local marker = e.raidmarker(f, healthbarBar, { size = 16 })
	marker:SetPoint('LEFT', healthbarBar, 'LEFT', 2, 0)

	e.range(f)

	return f
end)
