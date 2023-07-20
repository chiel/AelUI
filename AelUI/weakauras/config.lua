local addon = select(2, ...)

addon.weakauras.config = {
	groupTypes = {
		primary = {
			groupConfig = {
				anchorFrameType = 'SELECTFRAME',
				anchorFrameFrame = 'AelUIAnchor',
				anchorPoint = 'TOP',
				selfPoint = 'TOP',
				grow = 'CUSTOM',
				growOn = 'changed',
				customGrow = 'function(newPositions, activeRegions) AelUI.weakauras.growers.primary(newPositions, activeRegions) end',
			},
			childConfig = {
				width = 40,
				height = 40,
			},
		},

		secondary = {
			groupConfig = {
				anchorFrameType = 'SELECTFRAME',
				anchorFrameFrame = 'AelUIAnchor',
				anchorPoint = 'BOTTOM',
				selfPoint = 'TOP',
				yOffset = -2,
				grow = 'CUSTOM',
				growOn = 'changed',
				customGrow = 'function(newPositions, activeRegions) AelUI.weakauras.growers.secondary(newPositions, activeRegions) end',
			},
			childConfig = {
				width = 32,
				height = 32,
			},
		},

		defensives = {
			groupConfig = {
				anchorFrameType = 'SELECTFRAME',
				anchorFrameFrame = 'AelUIAnchor',
				anchorPoint = 'TOPLEFT',
				selfPoint = 'BOTTOMRIGHT',
				grow = 'LEFT',
				xOffset = -20,
				yOffset = 2,
			},
			childConfig = {
				width = 32,
				height = 32,
			},
		},

		aurabars = {
			groupConfig = {
				anchorFrameType = 'SELECTFRAME',
				anchorFrameFrame = 'AelUIAnchor',
				anchorPoint = 'TOP',
				selfPoint = 'BOTTOM',
				grow = 'UP',
				xOffset = 0,
				yOffset = 21,
			},
		},
	},
}
