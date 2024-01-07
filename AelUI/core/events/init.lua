local addon = select(2, ...)

local events = {}

local f = CreateFrame('Frame')
f:SetScript('OnEvent', function(self, event, ...)
	local callbacks = events[event]
	for _, callback in ipairs(callbacks) do
		callback(...)
	end
end)

addon.core.events = {
	register = function(type, callback)
		if events[type] == nil then
			f:RegisterEvent(type)
			events[type] = {}
		end

		table.insert(events[type], callback)
	end,
}
