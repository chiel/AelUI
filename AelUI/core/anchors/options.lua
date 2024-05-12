local ns = select(2, ...)

local description = {
	'In AelUI, most things are tied to the primary anchor for positioning. The primary anchor is automatically',
	'resized based on the WeakAuras that are in the primary group for the spec you are playing, but you can also',
	'set a minimum width for when there are fewer icons than this width.',
}

local config = {
	type = 'group',
	name = 'Anchor',
	args = {
		description = {
			order = 0,
			type = 'description',
			name = table.concat(description, ' '),
			fontSize = 'medium',
		},
	},
}

config.args.position = {
	order = 1,
	type = 'range',
	name = 'Position',
	desc = 'The Y-position of the primary anchor',
	min = 0,
	max = 400,
	step = 1,
	set = function(info, position)
		ns.anchors.primary:SetOffset(position)
	end,
	get = function(info)
		return ns.anchors.primary:GetOffset()
	end,
}

config.args.minimumWidth = {
	order = 2,
	type = 'range',
	name = 'Minimum Width',
	desc = 'The minimum width for the anchor',
	min = 0,
	max = 800,
	step = 1,
	set = function(info, width)
		ns.anchors.primary:SetMinimumWidth(width)
	end,
	get = function(info)
		return ns.anchors.primary:GetMinimumWidth()
	end,
}

ns.options.config.addSection('anchor', config)
