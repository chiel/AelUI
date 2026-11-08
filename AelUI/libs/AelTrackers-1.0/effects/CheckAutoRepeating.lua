local lib = LibStub('AelTrackers-1.0')

local CheckAutoRepeating = {}
CheckAutoRepeating.__index = CheckAutoRepeating

lib.effects.createCheckAutoRepeating = function(source, value)
	assert(type(source.IsAutoRepeating) == 'function', 'CheckAutoRepeating requires a source with IsAutoRepeating()')

	if source.RequireAutoRepeat then
		source:RequireAutoRepeat()
	end

	return setmetatable({
		source = source,
		value = value,
	}, CheckAutoRepeating)
end

function CheckAutoRepeating:Matches()
	return self.source:IsAutoRepeating() == self.value
end
