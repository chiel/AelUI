local _, ns = ...

ns.conditions.CreateCondition = function(trigger)
	local aura = {
		changes = {},
		check = nil,
	}

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
