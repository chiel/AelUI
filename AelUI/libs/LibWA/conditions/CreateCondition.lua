local addon = select(2, ...)

local variableMap = {
	auraFound = 'buffed',
}

addon.conditions.CreateCondition = function(trigger)
	local aura = {
		changes = {},
	}

	aura.ChangeColor = function(self, ...)
		local change = addon.conditions.ChangeColor(...)
		table.insert(self.changes, change)
	end

	aura.ChangeDesaturate = function(self, ...)
		local change = addon.conditions.ChangeDesaturate(...)
		table.insert(self.changes, change)
	end

	aura.ChangeGlowVisibility = function(self, ...)
		local change = addon.conditions.ChangeGlowVisibility(...)
		table.insert(self.changes, change)
	end

	aura.ChangeTextVisibility = function(self, ...)
		local change = addon.conditions.ChangeTextVisibility(...)
		table.insert(self.changes, change)
	end

	aura.CheckAuraFound = function(self, ...)
		self.check = addon.conditions.CheckAuraFound(...)
	end

	aura.CheckCharges = function(self, ...)
		self.check = addon.conditions.CheckCharges(...)
	end

	aura.CheckItemInRange = function(self, ...)
		self.check = addon.conditions.CheckItemInRange(...)
	end

	aura.CheckOnCooldown = function(self, ...)
		self.check = addon.conditions.CheckOnCooldown(...)
	end

	aura.CheckSpellInRange = function(self, ...)
		self.check = addon.conditions.CheckSpellInRange(...)
	end

	aura.CheckStacks = function(self, ...)
		self.check = addon.conditions.CheckStacks(...)
	end

	aura.CheckTriggerActive = function(self, ...)
		self.check = addon.conditions.CheckTriggerActive(...)
	end

	aura.Serialize = function(self)
		local r = { changes = {}, check = {} }

		if self.check ~= nil then
			r.check = self.check:Serialize()
		end

		for _, change in ipairs(self.changes) do
			table.insert(r.changes, change:Serialize())
		end

		return r
	end

	return aura
end
