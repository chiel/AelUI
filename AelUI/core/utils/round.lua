local addon = select(2, ...)

addon.core.utils.round = function(num)
	return math.floor(num + 0.5)
end
