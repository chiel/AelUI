local MAJOR, MINOR = 'AelEvents-1.0', 10000
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then
	return
end

lib.frames = lib.frames or {}
lib.listeners = lib.listeners or {
	global = {},
}

local frames = lib.frames
local listeners = lib.listeners

local function dispatch(ls, event, ...)
	for _, fn in ipairs(ls[event]) do
		fn(event, ...)
	end
end

lib.on = function(event, unit, fn)
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
