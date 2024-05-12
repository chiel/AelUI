local addon = select(2, ...)

addon.conditions.CheckStacks = function(trigger, operator, value)
	local aura = {
		trigger = trigger,
		value = value,
	}

	aura.Serialize = function(self)
		return {
			trigger = trigger.id,
			variable = 'stacks',
			op = operator,
			value = tostring(value),
		}
	end

	return aura
end
