local ns = select(2, ...)

local ce = ns.core.unitframes.elements

ns.retail.unitframes.createStyler = function(config)
	local coreStyler = ns.core.unitframes.createStyler(config)

	local indicators = config.indicators or {}
	local texts = config.texts or {}

	return function(self, unit)
		coreStyler(self, unit)
	end
end
