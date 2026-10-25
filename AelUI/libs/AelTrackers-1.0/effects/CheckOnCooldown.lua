local lib = LibStub('AelTrackers-1.0')

local CheckOnCooldown = {}
CheckOnCooldown.__index = CheckOnCooldown

lib.effects.createCheckOnCooldown = function(source, value)
	assert(type(source.IsOnCooldown) == 'function', 'CheckOnCooldown requires a source with IsOnCooldown()')

	if source.RequireCooldown then
		source:RequireCooldown()
	end

	return setmetatable({
		source = source,
		value = value,
	}, CheckOnCooldown)
end

function CheckOnCooldown:Matches()
	return self.source:IsOnCooldown() == self.value
end
