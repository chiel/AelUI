local addon = select(2, ...)

addon.load = {}

addon.load.Create = function()
	local aura = {
		conditions = {},
	}

	aura.Class = function(self, ...)
		local condition = addon.load.CreateClassCondition(...)
		table.insert(self.conditions, condition)
	end

	aura.ClassAndSpec = function(self, ...)
		local condition = addon.load.CreateClassAndSpecCondition(...)
		table.insert(self.conditions, condition)
	end

	aura.SpellKnown = function(self, ...)
		local condition = addon.load.CreateSpellKnownCondition(...)
		table.insert(self.conditions, condition)
	end

	aura.Serialize = function(self)
		local r = { load = {} }

		for _, condition in ipairs(self.conditions) do
			Mixin(r.load, condition:Serialize())
		end

		return r
	end

	return aura
end
