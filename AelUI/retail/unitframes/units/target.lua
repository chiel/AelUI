local ns = select(2, ...)

local anchors = ns.anchors
local createStyler = ns.unitframes.createStyler

table.insert(ns.unitframes.units, {
	name = 'target',
	spawn = function(self)
		local f = self:Spawn('target', 'AelUITarget')
		f:SetSize(40 * 7, 40)
		f:SetPoint('TOPLEFT', anchors.primary, 'TOPRIGHT', 20, 0)
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
