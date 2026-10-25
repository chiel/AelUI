local lib = LibStub('AelTrackers-1.0')

local CheckInRange = {}
CheckInRange.__index = CheckInRange

lib.effects.createCheckInRange = function(source, value)
	assert(type(source.IsInRange) == 'function', 'CheckInRange requires a source with IsInRange()')

	if source.RequireRange then
		source:RequireRange()
	end

	return setmetatable({
		source = source,
		value = value,
	}, CheckInRange)
end

function CheckInRange:Matches()
	return self.source:IsInRange() == self.value
end
