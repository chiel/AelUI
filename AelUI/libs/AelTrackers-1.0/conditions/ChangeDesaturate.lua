local lib = LibStub('AelTrackers-1.0')

local ChangeDesaturate = {}
ChangeDesaturate.__index = ChangeDesaturate

lib.conditions.createChangeDesaturate = function(target, value)
	assert(type(target.Desaturate) == 'function', 'ChangeDesaturate requires a target with Desaturate()')

	return setmetatable({
		target = target,
		value = value,
	}, ChangeDesaturate)
end

function ChangeDesaturate:Apply()
	self.target:Desaturate(self.value, true)
end
