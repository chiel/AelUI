local _, addon = ...

LibWA.CreateBar = function(id)
	local aura = addon.auras.createBase(id)
	aura.table.regionType = 'aurabar'

	return aura
end
