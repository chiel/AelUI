local addon = select(2, ...)

addon.utils.Round = function(num)
	return math.floor(num + 0.5)
end
