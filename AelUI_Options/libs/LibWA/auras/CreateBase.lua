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

	return aura
end
