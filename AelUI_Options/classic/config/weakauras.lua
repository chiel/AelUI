local addon = select(2, ...)

local weakaurasDescription =
	'When hitting one of the import buttons below, WeakAuras will open and import the WeakAuras. If the group already exists, you will be presented with the choice to copy, or update the existing group - always select "update".'

local config = {
	type = 'group',
	name = 'WeakAuras',
	args = {
		description = {
			order = 0,
			type = 'description',
			name = weakaurasDescription,
			fontSize = 'medium',
		},
	},
}

addon.core.config.addSection('weakauras', config)
