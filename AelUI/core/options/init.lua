local _, ns = ...

local dialog = LibStub('AceConfigDialog-3.0')
local registry = LibStub('AceConfigRegistry-3.0')

local config = {
	type = 'group',
	name = 'AelUI',
	args = {},
}

ns.options = {
	finalise = function()
		dialog:SetDefaultSize('AelUI', 800, 600)
		registry:RegisterOptionsTable('AelUI', config, false)

		ns.console:RegisterChatCommand('aelui', function()
			dialog:Open('AelUI')
		end)
	end,
}
