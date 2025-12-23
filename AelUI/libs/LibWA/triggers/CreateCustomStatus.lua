local _, ns = ...

ns.triggers.CreateCustomStatus = function(options)
	local o = options or {}

	local aura = {
		events = o.events,
		custom = o.custom,
	}

	aura.Serialize = function(self)
		return {
			trigger = {
				type = 'custom',
				custom_type = 'status',
				check = self.events ~= nil and 'event' or 'update',
				events = self.events,
				custom = self.custom,
			},
			untrigger = {},
		}
	end

	return aura
end
