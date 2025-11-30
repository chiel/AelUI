local _, ns = ...

ns.weakauras.import = function(data, children, callback)
	local inData = {
		d = data,
		c = children,
		v = 2000,
	}

	local ok, error = WeakAuras.Import(inData, nil, callback)
	if not ok and error ~= nil then
		ns.console:Printf('[AelUI] Error occured while trying to import WeakAuras: %s', error)
	end
end
