local addon = select(2, ...)

addon.load.CreateClassCondition = function(value)
	local aura = {
		value = type(value) == 'table' and value or { value },
	}

	aura.Serialize = function(self)
		if #self.value == 1 then
			return {
				use_class = true,
				class = {
					single = self.value[1],
				},
			}
		end

		local r = {
			use_class = false,
			class = {
				multi = {},
			},
		}

		for _, class in ipairs(self.value) do
			r.class.multi[class] = true
		end

		return r
	end

	return aura
end
