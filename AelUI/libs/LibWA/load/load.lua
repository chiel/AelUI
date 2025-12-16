local _, ns = ...

ns.load = {}

ns.load.Create = function()
	local aura = {
		conditions = {},
	}

	aura.Class = function(self, ...)
		local cond = ns.load.CreateClassCondition(...)
		table.insert(self.conditions, cond)
	end

	aura.Serialize = function(self)
		local r = { load = {} }

		for _, cond in ipairs(self.conditions) do
			Mixin(r.load, cond:Serialize())
		end

		return r
	end

	return aura
end
