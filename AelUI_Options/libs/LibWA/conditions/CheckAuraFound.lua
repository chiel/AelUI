local addon = select(2, ...)

addon.conditions.CheckAuraFound = function(trigger, value)
	local aura = {
		trigger = trigger,
		value = value,
	}

	aura.Serialize = function(self)
		return {
			trigger = trigger.id,
			variable = 'buffed',
			value = value and 1 or 0,
		}
	end

	return aura
end
