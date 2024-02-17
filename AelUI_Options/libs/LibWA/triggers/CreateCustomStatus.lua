local addon = select(2, ...)

addon.triggers.CreateCustomStatus = function(options)
	local o = options or {}

	local aura = {
		table = {
			trigger = {
				type = 'custom',
				custom_type = 'status',
				check = o.events ~= nil and 'event' or 'update',
				events = o.events,
				custom = o.custom,
			},
			untrigger = {},
		},
	}

	aura.Serialize = function(self)
		return self.table
	end

	return aura
end
