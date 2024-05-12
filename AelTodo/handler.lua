local addon = select(2, ...)

local eventPlugins = {}

local f = CreateFrame('Frame')
f:SetScript('OnEvent', function(self, event)
	C_Timer.After(1, function()
		local plugins = eventPlugins[event]

		for _, name in ipairs(plugins) do
			local plugin = addon.plugins[name]
			local sections = plugin.handler()
			WeakAuras.ScanEvents('AEL_TODO_UPDATE', name, {
				name = name,
				priority = plugin.priority,
				sections = sections,
			})
		end
	end)
end)

addon.registerEvent = function(event, name)
	if eventPlugins[event] == nil then
		eventPlugins[event] = {}
		f:RegisterEvent(event)
	end

	table.insert(eventPlugins[event], name)
end
