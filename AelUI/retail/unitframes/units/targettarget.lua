local ns = select(2, ...)

local createStyler = ns.unitframes.createStyler

table.insert(ns.unitframes.units, {
	name = 'targettarget',
	spawn = function(self)
		local f = self:Spawn('targettarget', 'AelUITargetTarget')
		f:SetSize(40 * 3.5, 32)
		f:SetPoint('TOPRIGHT', AelUITarget, 'BOTTOMRIGHT', 0, -16)
	end,
	style = createStyler({
		mirror = true,
		indicators = {
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
