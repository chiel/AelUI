local addon = select(2, ...)

addon.conditions.CheckSpellCount = function(trigger, operator, value)
	local aura = {
		trigger = trigger,
		value = value,
	}

	aura.Serialize = function(self)
		return {
			trigger = trigger.id,
			variable = 'spellCount',
			op = operator,
			value = tostring(value),
		}
	end

	return aura
end
