local addon = select(2, ...)

addon.conditions = {}

addon.conditions.Create = function()
	local aura = {
		conditions = {},
	}

	aura.Add = function(self, ...)
		local condition = addon.conditions.CreateCondition(...)
		table.insert(self.conditions, condition)
		return condition
	end

	aura.Serialize = function(self)
		local r = { conditions = {} }

		for i, condition in ipairs(self.conditions) do
			table.insert(r.conditions, condition:Serialize())
		end

		return r
	end

	return aura
end
