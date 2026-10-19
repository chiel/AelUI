local lib = LibStub('AelTrackers-1.0')

local CheckInRange = {}
CheckInRange.__index = CheckInRange

lib.conditions.createCheckInRange = function(trigger, value)
	assert(type(trigger.IsInRange) == 'function', 'CheckInRange requires a trigger with IsInRange()')

	trigger:Require('range')

	return setmetatable({
		trigger = trigger,
		value = value,
	}, CheckInRange)
end

function CheckInRange:Matches()
	return self.trigger:IsInRange() == self.value
end
