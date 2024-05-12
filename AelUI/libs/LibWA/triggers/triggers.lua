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

	aura.AddItemCooldown = function(self, ...)
		local trigger = addon.triggers.CreateItemCooldown(...)
		table.insert(self.triggers, trigger)
		return trigger
	end

	aura.AddItemCount = function(self, ...)
		local trigger = addon.triggers.CreateItemCount(...)
		table.insert(self.triggers, trigger)
		return trigger
	end

	aura.AddSpellActivationOverlay = function(self, ...)
		local trigger = addon.triggers.CreateSpellActivationOverlay(...)
		table.insert(self.triggers, trigger)
		return trigger
	end

	aura.AddSpellCooldown = function(self, ...)
		local trigger = addon.triggers.CreateSpellCooldown(...)
		table.insert(self.triggers, trigger)
		return trigger
	end

	aura.AddUnitCharacteristics = function(self, ...)
		local trigger = addon.triggers.CreateUnitCharacteristics(...)
		table.insert(self.triggers, trigger)
		return trigger
	end

	aura.Get = function(self, index)
		return self.triggers[index]
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
				r.triggers.customTriggerLogic = self.disjunctive.customTrigger
			end
		end

		return r
	end

	return aura
end
