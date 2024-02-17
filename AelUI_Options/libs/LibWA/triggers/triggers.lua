local addon = select(2, ...)

addon.triggers = {}

addon.triggers.Create = function()
	local aura = {
		triggers = {},
	}

	aura.AddAura = function(self, ...)
		local trigger = addon.triggers.CreateAura(...)
		table.insert(self.triggers, trigger)
		return trigger
	end

	aura.AddCustomStatus = function(self, ...)
		local trigger = addon.triggers.CreateCustomStatus(...)
		table.insert(self.triggers, trigger)
		return trigger
	end

	aura.AddSpellCooldown = function(self, ...)
		local trigger = addon.triggers.CreateSpellCooldown(...)
		table.insert(self.triggers, trigger)
		return trigger
	end

	aura.SetDisjunctive = function(self, disjunctive, customTrigger)
		if disjunctive == nil then
			self.disjunctive = nil
		end

		self.disjunctive = {
			type = disjunctive,
			customTrigger = customTrigger,
		}
	end

	aura.Serialize = function(self)
		local r = { triggers = {} }

		for i, trigger in ipairs(self.triggers) do
			trigger.id = i
			r.triggers[i] = trigger:Serialize()
		end

		if self.disjunctive ~= nil then
			r.triggers.disjunctive = self.disjunctive.type
			if self.disjunctive.type == 'custom' then
				r.triggers.customTriggerLogic = this.disjunctive.customTrigger
			end
		end

		return r
	end

	return aura
end
