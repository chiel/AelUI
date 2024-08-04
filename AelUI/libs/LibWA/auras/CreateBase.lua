local _, addon = ...

addon.auras.CreateBase = function(id)
	local aura = { id = id }

	aura.SetParent = function(self, parentId)
		self.parent = parentId
	end

	aura.Serialize = function(self)
		local r = {
			internalVersion = addon.internalVersion,
			id = id,
			uid = id,
		}

		if self.parent ~= nil then
			r.parent = self.parent
		end

		return r
	end

	return aura
end
