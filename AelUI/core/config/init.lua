local addon = select(2, ...)

local width, height = GetPhysicalScreenSize()

local icons = {
	spacing = 2,

	primary = {
		minCount = 7,
		size = 40,
	},
	secondary = {
		minCount = 7,
		size = 32,
	},
}

local p = icons.primary
local s = icons.secondary

local anchors = {
	primary = {
		height = p.size,
		minWidth = (p.minCount * p.size) + ((p.minCount - 1) * icons.spacing),
	},
	secondary = {
		height = s.size,
		minWidth = (s.minCount * s.size) + ((s.minCount - 1) * icons.spacing),
	},
}

addon.core.config = {
	anchors = anchors,
	icons = icons,
	screenSize = { width = width, height = height },
	unitframes = {
		height = p.size,
	},
}
