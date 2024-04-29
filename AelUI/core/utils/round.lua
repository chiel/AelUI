local ns = select(2, ...)

ns.core.utils.round = function(num)
	return math.floor(num + 0.5)
end
