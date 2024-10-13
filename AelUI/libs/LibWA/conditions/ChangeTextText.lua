local _, addon = ...

addon.conditions.ChangeTextText = function(text, value)
	local aura = {
		text = text,
		value = value,
	}

	aura.Serialize = function(self)
		return {
			property = 'sub.' .. text.id .. '.text_text',
			value = self.value,
		}
	end

	return aura
end
