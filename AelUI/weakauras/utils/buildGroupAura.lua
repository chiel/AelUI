local addon = select(2, ...)

local c = addon.weakauras.config

addon.weakauras.utils.buildGroupAura = function(data)
	return Mixin({
		regionType = 'dynamicgroup',
		controlledChildren = {},
	}, c.groupTypes[data.type].groupConfig)
end
