local _, ns = ...

ns.conditions.ChangeDesaturate = function(value)
	local aura = {
		value = value,
	}

	aura.Serialize = function(self)
		return {
			property = 'desaturate',
			value = self.value,
		}
	end

	return aura
end
