local _, ns = ...

ns.conditions.ChangeGlowVisibility = function(glow, value)
	local aura = {
		glow = glow,
		value = value,
	}

	aura.Serialize = function(self)
		return {
			property = 'sub.' .. self.glow.id .. '.glow',
			value = self.value,
		}
	end

	return aura
end
