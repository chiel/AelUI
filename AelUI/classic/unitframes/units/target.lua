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

		return f
	end,
})
