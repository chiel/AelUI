local _, ns = ...

ns.conditions.ChangeBorderColor = function(border, value)
	local aura = {
		border = border,
		value = value,
	}

	aura.Serialize = function(self)
		return {
			property = 'sub.' .. self.border.id .. '.border_color',
			value = self.value,
		}
	end

	return aura
end
