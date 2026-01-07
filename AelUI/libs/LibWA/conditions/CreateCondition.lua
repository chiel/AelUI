local _, ns = ...

ns.conditions.CreateCondition = function(trigger)
	local aura = {
		changes = {},
		check = nil,
	}

	aura.ChangeBorderColor = function(self, ...)
		local change = ns.conditions.ChangeBorderColor(...)
		table.insert(self.changes, change)
	end

	aura.ChangeColor = function(self, ...)
		local change = ns.conditions.ChangeColor(...)
		table.insert(self.changes, change)
	end

	aura.ChangeDesaturate = function(self, ...)
		local change = ns.conditions.ChangeDesaturate(...)
		table.insert(self.changes, change)
	end

	aura.ChangeGlowVisibility = function(self, ...)
		local change = ns.conditions.ChangeGlowVisibility(...)
		table.insert(self.changes, change)
	end

	aura.CheckActive = function(self, ...)
		self.check = ns.conditions.CheckActive(...)
	end

	aura.CheckAuraFound = function(self, ...)
		self.check = ns.conditions.CheckAuraFound(...)
	end

	aura.CheckOnCooldown = function(self, ...)
		self.check = ns.conditions.CheckOnCooldown(...)
	end

	aura.CheckSpellInRange = function(self, ...)
		self.check = ns.conditions.CheckSpellInRange(...)
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
