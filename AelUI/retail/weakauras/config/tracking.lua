local ns = select(2, ...)

ns.weakauras.config.tracking = {
	name = 'Tracking',
	groupConfig = {
		anchor = {
			type = 'SELECTFRAME',
			frame = 'AelUIPrimaryAnchor',
			from = 'BOTTOM',
			to = 'TOP',
			x = 0,
			y = 20,
		},
		grow = {
			type = 'HORIZONTAL',
			align = 'RIGHT',
		},
	},
	childConfig = {
		width = 40,
		height = 35,
	},
}
