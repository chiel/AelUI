local lib = LibStub('AelTrackers-1.0')

local ChangeColor = {}
ChangeColor.__index = ChangeColor

lib.conditions.createChangeColor = function(target, value)
	assert(type(target.Color) == 'function', 'ChangeColor requires a target with Color()')

	return setmetatable({
		target = target,
		value = value,
	}, ChangeColor)
end

function ChangeColor:Apply()
	self.target:Color(self.value, true)
end
