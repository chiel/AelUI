local _, ns = ...

local a = ns.anchors
local e = ns.unitframes.elements

table.insert(ns.unitframes.units, {
	name = 'pet',

	spawn = function(self)
		local f = self:Spawn('pet', 'AelUIPet')
		f:SetSize(150, 30)
		f:SetPoint('BOTTOMRIGHT', 'AelUIPlayer', 'BOTTOMLEFT', -20, 0)
	end,

	style = ns.unitframes.createStyler({
		texts = {
			health = true,
			healthpercent = true,
		},
	}),
})
