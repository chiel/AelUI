local _, ns = ...

local events = ns.events

local frames = {}
local listeners = {
	global = {},
}

local function dispatch(ls, event, ...)
	for _, fn in ipairs(ls[event]) do
		fn(event, ...)
	end
end

events.on = function(event, unit, fn)
	if fn == nil then
		fn = unit
		unit = nil
	end

	unit = unit or 'global'

	local unitListeners = listeners[unit]
	if not unitListeners then
		unitListeners = {}
		listeners[unit] = unitListeners
	end

	local eventListeners = unitListeners[event]
	if not eventListeners then
		eventListeners = {}
		unitListeners[event] = eventListeners

		local frame = frames[unit]
		if not frame then
			frame = CreateFrame('Frame')
			frame:SetScript('OnEvent', function(_, name, ...)
				dispatch(unitListeners, name, ...)
			end)
			frames[unit] = frame
		end

		if unit == 'global' then
			frame:RegisterEvent(event)
		else
			frame:RegisterUnitEvent(event, unit)
		end
	end

	table.insert(eventListeners, fn)
end
