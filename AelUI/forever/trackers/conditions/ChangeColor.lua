local _, ns = ...

local ChangeColor = {}
ChangeColor.__index = ChangeColor

ns.trackers.conditions.createChangeColor = function(target, value)
	assert(type(target.Color) == 'function', 'ChangeColor requires a target with Color()')

	return setmetatable({
		target = target,
		value = value,
	}, ChangeColor)
end

function ChangeColor:Apply()
	self.target:Color(self.value, true)
end
