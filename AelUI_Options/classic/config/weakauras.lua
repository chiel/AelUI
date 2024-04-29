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

local lastIndex = 0

for key, classData in pairs(addon.classic.weakauras.classes) do
	lastIndex = lastIndex + 1
	config.args[key] = {
		order = lastIndex,
		type = 'execute',
		name = classData.name,
		desc = 'Import ' .. classData.name .. ' WeakAuras',
		func = function()
			local data, children = addon.classic.weakauras.convertClassData(classData)
			addon.core.weakauras.import(data, children, function()
				addon.console:Printf('[AelUI] WeakAuras group %s done', classData.name)
			end)
		end,
	}
end

addon.core.config.addSection('weakauras', config)
