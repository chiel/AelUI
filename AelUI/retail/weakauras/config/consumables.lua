local ns = select(2, ...)

ns.weakauras.config.consumables = {
	name = 'Consumables',
	groupConfig = {
		anchor = {
			type = 'SELECTFRAME',
			frame = 'AelUIPrimaryAnchor',
			from = 'TOPLEFT',
			to = 'BOTTOMLEFT',
			x = -300,
			y = -2,
		},
		grow = {
			type = 'RIGHT',
			align = 'LEFT',
		},
	},
	childConfig = {
		width = 36,
		height = 32,
	},
}
