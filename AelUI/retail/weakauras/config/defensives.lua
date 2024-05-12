local ns = select(2, ...)

ns.weakauras.config.defensives = {
	name = 'Defensives',
	groupConfig = {
		anchor = {
			type = 'SELECTFRAME',
			frame = 'AelUIPrimaryAnchor',
			from = 'BOTTOMRIGHT',
			to = 'TOPLEFT',
			x = -20,
			y = 2,
		},
		grow = {
			type = 'LEFT',
			align = 'RIGHT',
		},
	},
	childConfig = {
		width = 36,
		height = 32,
	},
}
