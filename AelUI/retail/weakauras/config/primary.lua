local ns = select(2, ...)

ns.weakauras.config.primary = {
	name = 'Primary',
	groupConfig = {
		anchor = {
			type = 'SELECTFRAME',
			frame = 'AelUIPrimaryAnchor',
			from = 'TOP',
			to = 'TOP',
		},
		grow = {
			type = 'CUSTOM',
			on = 'changed',
			custom = 'function(newPositions, activeRegions) AelUI.weakauras.growers.primary(newPositions, activeRegions) end',
		},
	},
}
