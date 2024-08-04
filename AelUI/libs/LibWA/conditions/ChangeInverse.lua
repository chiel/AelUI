local _, addon = ...

addon.conditions.ChangeInverse = function(value)
	local aura = {
		value = value,
	}

	aura.Serialize = function(self)
		return {
			property = 'inverse',
			value = self.value,
		}
	end

	return aura
end
