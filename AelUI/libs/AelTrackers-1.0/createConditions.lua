local lib = LibStub('AelTrackers-1.0')

local Conditions = {}
Conditions.__index = Conditions

lib.createConditions = function()
	return setmetatable({ entries = {} }, Conditions)
end

function Conditions:Add()
	local condition = lib.createCondition()
	tinsert(self.entries, condition)
	return condition
end

function Conditions:Apply(tracker)
	for _, condition in ipairs(self.entries) do
		if condition:Matches() then
			condition:Apply(tracker)
		end
	end
end
