local ns = select(2, ...)

ns.weakauras.config.secondary = {
	name = 'Secondary',
	groupConfig = {
		anchor = {
			type = 'SELECTFRAME',
			frame = 'AelUISecondaryAnchor',
			from = 'TOP',
			to = 'TOP',
		},
		grow = {
			type = 'CUSTOM',
			on = 'changed',
			custom = 'function(newPositions, activeRegions) AelUI.weakauras.growers.secondary(newPositions, activeRegions) end',
		},
	},
}
