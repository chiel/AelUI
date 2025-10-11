local _, addon = ...

local eventMap = {
	['combat:entering'] = {
		event = 'Combat Events',
		eventtype = 'PLAYER_REGEN_DISABLED',
	},
}

addon.triggers.CreateEvent = function(event, options)
	local o = options or {}
	local aura = {}

	aura.Serialize = function(self)
		local t = {
			type = 'event',
		}

		local props = eventMap[event]
		if props ~= nil then
			Mixin(t, props)
		end

		if o.duration ~= nil then
			t.duration = tostring(o.duration)
		end

		return {
			trigger = t,
			untrigger = {},
		}
	end

	return aura
end
