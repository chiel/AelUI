local addon = select(2, ...)

addon.core.weakauras.import = function(data, children, callback)
	local inData = {
		d = data,
		c = children,
		v = 2000,
	}

	local ok, error = WeakAuras.Import(inData, nil, callback)
	if not ok and error ~= nil then
		addon.console:Printf('[AelUI] Error occured while trying to import WeakAuras: %s', error)
	end
end
