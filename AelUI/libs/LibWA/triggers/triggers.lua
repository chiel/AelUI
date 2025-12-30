local _, ns = ...

ns.triggers = {}

ns.triggers.Create = function()
	local aura = {
		activateOn = nil,
		triggers = {},
	}

	aura.AddAura = function(self, ...)
		local trigger = ns.triggers.CreateAura(...)
		table.insert(self.triggers, trigger)
		return trigger
	end

	aura.AddCustomStatus = function(self, ...)
		local trigger = ns.triggers.CreateCustomStatus(...)
		table.insert(self.triggers, trigger)
		return trigger
	end

	aura.AddSpellCooldown = function(self, ...)
		local trigger = ns.triggers.CreateSpellCooldown(...)
		table.insert(self.triggers, trigger)
		return trigger
	end

	aura.Get = function(self, index)
		return self.triggers[index]
	end

	aura.SetActivateOn = function(self, type, customFn)
		if type == nil then
			self.type = nil
		end

		self.activateOn = {
			type = type,
			customFn = customFn,
		}
	end

	aura.Serialize = function(self)
		local r = { triggers = {} }

		for i, trigger in ipairs(self.triggers) do
			trigger.id = i
			r.triggers[i] = trigger:Serialize()
		end

		if self.activateOn ~= nil then
			r.triggers.disjunctive = self.activateOn.type
			if self.activateOn.type == 'custom' then
				r.triggers.customTriggerLogic = self.activateOn.customFn
			end
		end

		return r
	end

	return aura
end
