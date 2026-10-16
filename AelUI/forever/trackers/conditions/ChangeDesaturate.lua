local _, ns = ...

local ChangeDesaturate = {}
ChangeDesaturate.__index = ChangeDesaturate

ns.trackers.conditions.createChangeDesaturate = function(target, value)
	assert(type(target.Desaturate) == 'function', 'ChangeDesaturate requires a target with Desaturate()')

	return setmetatable({
		target = target,
		value = value,
	}, ChangeDesaturate)
end

function ChangeDesaturate:Apply()
	self.target:Desaturate(self.value, true)
end
