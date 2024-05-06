local ns = select(2, ...)

ns.options.config.register = function()
	ns.options.dialog:SetDefaultSize('AelUI', 800, 600)
	ns.options.registry:RegisterOptionsTable('AelUI', ns.options.config.table, false)

	ns.options.console:RegisterChatCommand('aelui', function()
		ns.options.dialog:Open('AelUI')
	end)
end
