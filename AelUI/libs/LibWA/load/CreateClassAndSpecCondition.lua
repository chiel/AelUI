local addon = select(2, ...)

addon.load.CreateClassAndSpecCondition = function(value)
	local aura = {
		value = type(value) == 'table' and value or { value },
	}

	aura.Serialize = function(self)
		if #self.value == 1 then
			return {
				use_class_and_spec = true,
				class_and_spec = {
					single = self.value[1],
				},
			}
		end

		local r = {
			use_class_and_spec = false,
			class_and_spec = {
				multi = {},
			},
		}

		for _, specId in ipairs(self.value) do
			r.class_and_spec.multi[specId] = true
		end

		return r
	end

	return aura
end
