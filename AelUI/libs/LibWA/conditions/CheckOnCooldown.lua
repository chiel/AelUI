local addon = select(2, ...)

addon.conditions.CheckOnCooldown = function(trigger, value)
	local aura = {
		trigger = trigger,
		value = value,
	}

	aura.Serialize = function(self)
		return {
			trigger = trigger.id,
			variable = 'onCooldown',
			value = value and 1 or 0,
		}
	end

	return aura
end
