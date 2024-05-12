local addon = select(2, ...)

addon.plugins = {}
-- addon.pluginsByName = {}

AelTodo.RegisterPlugin = function(plugin)
	addon.plugins[plugin.name] = plugin
	-- table.insert(addon.plugins, plugin)

	for _, event in ipairs(plugin.events) do
		addon.registerEvent(event, plugin.name)
	end
end
