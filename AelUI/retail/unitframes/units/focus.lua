local ns = select(2, ...)

local anchors = ns.anchors
local createStyler = ns.unitframes.createStyler

table.insert(ns.unitframes.units, {
	name = 'focus',
	spawn = function(self)
		local f = self:Spawn('focus', 'AelUIFocus')
		f:SetSize(40 * 5, 40)
		f:SetPoint('BOTTOMRIGHT', anchors.primary, 'TOPLEFT', -60, 140)
	end,
	style = createStyler({
		indicators = {
			raidmarker = true,
		},
		texts = {
			health = true,
			healthpercent = true,
			name = true,
		},
	}),
})
