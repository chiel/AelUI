local addon = select(2, ...)

addon.weakauras.import = function(group)
	local classData = addon.weakauras.classes[group]
	if not classData then
		addon.console:Printf('[AelUI] No WeakAuras found for group %s.', group)
		return
	end

	local classAura, childAuras = addon.weakauras.utils.buildClassAuras(classData)
	local inData = {
		d = classAura,
		c = childAuras,
		v = 2000,
	}

	local ok, error = WeakAuras.Import(inData, nil, function()
		addon.console:Printf('[AelUI] WeakAuras group %s done.', group)
	end)

	if not ok and error ~= nil then
		addon.console:Printf('[AelUI] Error occured while trying to import WeakAuras: %s', error)
	end
end
