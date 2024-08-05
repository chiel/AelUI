local _, ns = ...

local dialog = LibStub('AceConfigDialog-3.0')
local registry = LibStub('AceConfigRegistry-3.0')

local config = {
	type = 'group',
	name = 'AelUI',
	args = {},
}

local sections = {}

ns.options = {
	addSection = function(key, config)
		table.insert(sections, { key = key, config = config })
	end,

	finalise = function()
		for i, section in ipairs(sections) do
			config.args[section.key] = Mixin({ order = i }, section.config)
		end

		dialog:SetDefaultSize('AelUI', 800, 600)
		registry:RegisterOptionsTable('AelUI', config, false)

		ns.console:RegisterChatCommand('aelui', function()
			dialog:Open('AelUI')
		end)
	end,
}
