local addon = select(2, ...)

addon.auras.CreateBase = function(id)
	local aura = {
		id = id,
		table = {
			internalVersion = addon.internalVersion,
			id = id,
			uid = id,
		},
	}

	aura.SetParent = function(self, parentId)
		self.table.parent = parentId
	end

	return aura
end
