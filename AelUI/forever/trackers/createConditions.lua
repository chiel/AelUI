local _, ns = ...

local Conditions = {}
Conditions.__index = Conditions

ns.trackers.createConditions = function()
	return setmetatable({ entries = {} }, Conditions)
end

function Conditions:Add()
	local condition = ns.trackers.createCondition()
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
