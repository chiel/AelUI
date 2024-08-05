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
	local classKeys = {}
	for key, _ in pairs(ns.weakauras.data.classes) do
		table.insert(classKeys, key)
	end
	table.sort(classKeys)

	for i, key in ipairs(classKeys) do
		local classData = ns.weakauras.data.classes[key]

		config.args[key] = {
			order = i,
			type = 'execute',
			name = classData.name,
			desc = 'Import ' .. classData.name .. ' WeakAuras',
			image = classData.icon,
			imageWidth = 48,
			imageHeight = 48,
			func = function()
				local data, children = ns.weakauras.convertClassData(classData)
				ns.weakauras.import(data, children, function()
					ns.console:Printf('[AelUI] WeakAuras group %s done', classData.name)
				end)
			end,
		}
	end

	ns.options.addSection('weakauras', config)
end)
