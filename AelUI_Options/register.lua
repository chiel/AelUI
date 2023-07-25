local addon = select(2, ...)

local options = {
	type = 'group',
	name = 'AelUI',
	args = {
		weakauras = addon.options.weakauras,
	},
}

addon.dialog:SetDefaultSize('AelUI', 800, 600)
addon.registry:RegisterOptionsTable('AelUI', options, false)

addon.console:RegisterChatCommand('aelui', function()
	addon.dialog:Open 'AelUI'
end)
