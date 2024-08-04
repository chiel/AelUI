local _, addon = ...

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

	aura.Get = function(self, index)
		return self.conditions[index]
	end

	aura.Move = function(self, cond, layer)
		local newConditions = {}
		for i, c in ipairs(self.conditions) do
			if c ~= cond then
				if i == layer then
					table.insert(newConditions, cond)
				end

				table.insert(newConditions, c)
			end
		end

		self.conditions = newConditions
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
