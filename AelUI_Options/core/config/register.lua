local addon = select(2, ...)

addon.core.config.register = function()
	addon.dialog:SetDefaultSize('AelUI', 800, 600)
	addon.registry:RegisterOptionsTable('AelUI', addon.core.config.options, false)

	addon.console:RegisterChatCommand('aelui', function()
		addon.dialog:Open('AelUI')
	end)
end
