local _, ns = ...

ns.triggers = {}

ns.triggers.Create = function()
	local aura = {
		triggers = {},
	}

	aura.AddSpellCooldown = function(self, ...)
		local trigger = ns.triggers.CreateSpellCooldown(...)
		table.insert(self.triggers, trigger)
		return trigger
	end

	aura.Serialize = function(self)
		local r = { triggers = {} }

		for i, trigger in ipairs(self.triggers) do
			trigger.id = i
			r.triggers[i] = trigger:Serialize()
		end

		return r
	end

	return aura
end
