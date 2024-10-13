local _, ns = ...

ns.weakauras.config = {
	primary = {
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
		childConfig = {
			width = 40,
			height = 40,
		},
	},

	secondary = {
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
		childConfig = {
			width = 34,
			height = 34,
		},
	},

	tracking = {
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
	},

	reminders = {
		name = 'Reminders',
		groupConfig = {
			anchor = {
				type = 'SELECTFRAME',
				frame = 'AelUIPrimaryAnchor',
				from = 'BOTTOM',
				to = 'TOP',
				x = 0,
				y = 80,
			},
			grow = {
				type = 'HORIZONTAL',
				align = 'RIGHT',
			},
		},
		childConfig = {
			width = 48,
			height = 48,
		},
	},

	defensives = {
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
	},

	consumables = {
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
	},
}
