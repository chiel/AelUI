local _, ns = ...

ns.load.CreateClassCondition = function(value)
	local aura = {
		value = value,
	}

	aura.Serialize = function(self)
		if type(self.value) ~= 'table' then
			return {
				use_class = true,
				class = {
					single = self.value,
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
