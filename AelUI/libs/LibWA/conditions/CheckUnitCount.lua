local _, addon = ...

addon.conditions.CheckUnitCount = function(trigger, operator, value)
	local aura = {
		trigger = trigger,
		value = value,
	}

	aura.Serialize = function(self)
		return {
			trigger = trigger.id,
			variable = 'unitCount',
			op = operator,
			value = tostring(value),
		}
	end

	return aura
end
