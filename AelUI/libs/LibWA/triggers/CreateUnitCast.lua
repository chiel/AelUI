local _, addon = ...

addon.triggers.CreateUnitCast = function(unit, options)
	local aura = {
		table = {
			trigger = {
				type = 'unit',
				event = 'Cast',
				unit = unit,
			},
			untrigger = {},
		},
	}

	aura.Serialize = function(self)
		return self.table
	end

	return aura
end
