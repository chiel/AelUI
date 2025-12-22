local _, ns = ...

ns.conditions.CreateCondition = function(trigger)
	local aura = {
		changes = {},
		check = nil,
	}

	aura.ChangeColor = function(self, ...)
		local change = ns.conditions.ChangeColor(...)
		table.insert(self.changes, change)
	end

	aura.ChangeDesaturate = function(self, ...)
		local change = ns.conditions.ChangeDesaturate(...)
		table.insert(self.changes, change)
	end

	aura.CheckOnCooldown = function(self, ...)
		self.check = ns.conditions.CheckOnCooldown(...)
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
