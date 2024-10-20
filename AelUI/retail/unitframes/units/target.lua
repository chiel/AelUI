local _, ns = ...

local a = ns.anchors
local e = ns.unitframes.elements

table.insert(ns.unitframes.units, {
	name = 'target',

	spawn = function(self)
		local f = self:Spawn('target', 'AelUITarget')
		f:SetSize(300, 40)
		f:SetPoint('TOPLEFT', a.primary, 'TOPRIGHT', 20, 0)
	end,

	style = ns.unitframes.createStyler({
		mirror = true,
		texts = {
			health = true,
			healthpercent = true,
		},
	}),
})
