local _, ns = ...

local a = ns.anchors
local e = ns.unitframes.elements

table.insert(ns.unitframes.units, {
	name = 'targettarget',

	spawn = function(self)
		local f = self:Spawn('targettarget', 'AelUITargetTarget')
		f:SetSize(150, 30)
		f:SetPoint('BOTTOMLEFT', 'AelUITarget', 'BOTTOMRIGHT', 20, 0)
	end,

	style = ns.unitframes.createStyler({
		texts = {
			health = true,
			healthpercent = true,
		},
	}),
})
