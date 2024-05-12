local addon = select(2, ...)

addon.conditions.ChangeColor = function(value)
	local aura = {
		value = value,
	}

	aura.Serialize = function(self)
		return {
			property = 'color',
			value = self.value,
		}
	end

	return aura
end
