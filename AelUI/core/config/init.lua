local ns = select(2, ...)

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

ns.config = {
	anchors = anchors,
	icons = icons,
	unitframes = {
		height = p.size,
	},
}
