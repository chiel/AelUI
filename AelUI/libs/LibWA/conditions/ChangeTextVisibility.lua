local _, addon = ...

addon.conditions.ChangeTextVisibility = function(text, value)
	local aura = {
		text = text,
		value = value,
	}

	aura.Serialize = function(self)
		return {
			property = 'sub.' .. text.id .. '.text_visible',
			value = self.value,
		}
	end

	return aura
end
