local _, ns = ...

local pc = ns.config.groups.primary
local sc = ns.config.groups.secondary

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
			spacing = pc.spacing,
		},
		childConfig = {
			width = pc.width,
			height = pc.height,
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
			spacing = sc.spacing,
		},
		childConfig = {
			width = sc.width,
			height = sc.height,
		},
	},
}
