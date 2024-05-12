local ns = select(2, ...)

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

local classKeys = {}
for key, _ in pairs(ns.weakauras.classes) do
	table.insert(classKeys, key)
end

table.sort(classKeys)

for _, key in ipairs(classKeys) do
	local classData = ns.weakauras.classes[key]
	lastIndex = lastIndex + 1
	config.args[key] = {
		order = lastIndex,
		type = 'execute',
		name = classData.name,
		desc = 'Import ' .. classData.name .. ' WeakAuras',
		image = classData.icon,
		imageWidth = 52,
		imageHeight = 52,
		func = function()
			local data, children = ns.weakauras.convertClassData(classData)
			ns.weakauras.import(data, children, function()
				ns.options.console:Printf('[AelUI] WeakAuras group %s done', classData.name)
			end)
		end,
	}
end

ns.options.config.addSection('weakauras', config)
