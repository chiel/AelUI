local _, addon = ...

addon.conditions.CheckSpellUsable = function(trigger, value)
	local aura = {
		trigger = trigger,
		value = value,
	}

	aura.Serialize = function(self)
		return {
			trigger = trigger.id,
			variable = 'spellUsable',
			value = value and 1 or 0,
		}
	end

	return aura
end
