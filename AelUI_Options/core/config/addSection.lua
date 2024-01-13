local addon = select(2, ...)

local lastIndex = -1

addon.core.config.addSection = function(key, config)
	lastIndex = lastIndex + 1
	addon.core.config.options.args[key] = Mixin({ order = lastIndex }, config)
end
