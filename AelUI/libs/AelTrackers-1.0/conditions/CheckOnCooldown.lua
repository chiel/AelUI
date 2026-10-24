local lib = LibStub('AelTrackers-1.0')

local CheckOnCooldown = {}
CheckOnCooldown.__index = CheckOnCooldown

lib.conditions.createCheckOnCooldown = function(trigger, value)
	assert(type(trigger.IsOnCooldown) == 'function', 'CheckOnCooldown requires a trigger with IsOnCooldown()')

	trigger:Require('cooldown')

	return setmetatable({
		trigger = trigger,
		value = value,
	}, CheckOnCooldown)
end

function CheckOnCooldown:Matches()
	return self.trigger:IsOnCooldown() == self.value
end
