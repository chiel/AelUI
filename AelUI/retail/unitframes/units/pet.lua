local ns = select(2, ...)

local createStyler = ns.unitframes.createStyler

table.insert(ns.unitframes.units, {
	name = 'pet',
	spawn = function(self)
		local f = self:Spawn('pet', 'AelUIPet')
		f:SetSize(40 * 3.5, 32)
		f:SetPoint('TOPLEFT', AelUIPlayer, 'BOTTOMLEFT', 0, -16)
	end,
	style = createStyler({
		indicators = {
			combat = true,
			leader = true,
			raidmarker = true,
		},
		texts = {
			health = true,
			healthpercent = true,
			level = true,
			name = true,
		},
	}),
})
