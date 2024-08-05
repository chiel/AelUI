local _, ns = ...

local config = {
	type = 'group',
	name = 'WeakAuras',
	args = {
		description = {
			order = 0,
			type = 'description',
			name = 'Import weakauras by clicking an icon below.',
			fontSize = 'medium',
		},
	},
}

ns.OnEnable(function()
	ns.options.addSection('weakauras', config)
end)
