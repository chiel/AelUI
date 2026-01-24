local _, ns = ...

local e = ns.unitframes.elements
local m = ns.media

table.insert(ns.unitframes.units, {
	unit = 'target',
	style = function(f)
		f:SetPoint('TOPLEFT', AelUIPrimaryAnchor, 'TOPRIGHT', 20, 0)
		f:SetSize(280, 60)

		local healthbar = e.healthbar(f)
		healthbar:SetAllPoints()

		local powerbar = e.powerbar(f)
		powerbar:SetPoint('TOPLEFT', healthbar, 'BOTTOMLEFT', 0, -2)
		powerbar:SetSize(140, 8)

		return f
	end,
})
