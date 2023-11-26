local addon = select(2, ...)

AelUI.weakauras = {}
addon.weakauras = {}

local playerClass = select(2, UnitClass('player'))
playerClass = string.lower(playerClass)

addon.weakauras.import = function()
	local classData = addon.weakauras.classes[playerClass]
	if not classData then
		print('[AelUI] No WeakAuras available for your class - sorry!')
		return
	end

	local classAura, childAuras = addon.weakauras.utils.buildClassAuras(classData)
	local inData = {
		d = classAura,
		c = childAuras,
		v = 2000,
	}

	local ok, error = WeakAuras.Import(inData, nil, function()
		print('[AelUI] WeakAuras import done')
	end)

	if not ok and error ~= nil then
		print('[AelUI] Error occured while trying to import WeakAuras', error)
	end
end
