local addon = select(2, ...)

addon.weakauras.utils.buildSpecAura = function(data)
	return {
		regionType = 'group',
		groupIcon = data.icon,
		controlledChildren = {},
	}
end
