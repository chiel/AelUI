local MAJOR, MINOR = 'AelTrackers-1.0', 10000
local lib = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then
	return
end

lib.defaults = lib.defaults or {}

local function merge(target, source)
	for key, value in pairs(source) do
		if type(value) == 'table' and type(target[key]) == 'table' then
			merge(target[key], value)
		else
			target[key] = value
		end
	end

	return target
end

lib.setDefaults = function(defaults)
	merge(lib.defaults, defaults)
end
