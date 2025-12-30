local _, ns = ...

local gc = ns.config.groups

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
			spacing = gc.primary.spacing,
		},
		childConfig = {
			width = gc.primary.width,
			height = gc.primary.height,
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
			spacing = gc.secondary.spacing,
		},
		childConfig = {
			width = gc.secondary.width,
			height = gc.secondary.height,
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
			width = gc.tracking.width,
			height = gc.tracking.height,
		},
	},
}
