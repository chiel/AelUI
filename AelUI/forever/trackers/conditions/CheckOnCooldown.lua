local _, ns = ...

local CheckOnCooldown = {}
CheckOnCooldown.__index = CheckOnCooldown

ns.trackers.conditions.createCheckOnCooldown = function(trigger, value)
	assert(type(trigger.IsOnCooldown) == 'function', 'CheckOnCooldown requires a trigger with IsOnCooldown()')

	return setmetatable({
		trigger = trigger,
		value = value,
	}, CheckOnCooldown)
end

function CheckOnCooldown:Matches()
	return self.trigger:IsOnCooldown() == self.value
end
