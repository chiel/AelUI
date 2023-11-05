local addon = select(2, ...)

local weakaurasDescription =
	'When hitting one of the import buttons below, WeakAuras will open and import the WeakAuras. If the group already exists, you will be presented with the choice to copy, or update the existing group - always select "update".'

local options = {
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

local groups = {
	-- 'general',
	'deathknight',
	-- 'demonhunter',
	'druid',
	'evoker',
	-- 'hunter',
	-- 'mage',
	'monk',
	'paladin',
	'priest',
	-- 'rogue',
	'shaman',
	'warlock',
	'warrior',
}

for i, name in ipairs(groups) do
	local fullName = addon.weakauras.classes[name].name

	options.args[name] = {
		order = i,
		type = 'execute',
		name = fullName,
		desc = 'Import ' .. fullName .. ' WeakAuras',
		func = function()
			addon.weakauras.import(name)
		end,
	}
end

addon.options.weakauras = options
