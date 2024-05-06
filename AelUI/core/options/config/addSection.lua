local ns = select(2, ...)

local lastIndex = -1

ns.options.config.addSection = function(key, config)
	lastIndex = lastIndex + 1
	ns.options.config.table.args[key] = Mixin({ order = lastIndex }, config)
end
