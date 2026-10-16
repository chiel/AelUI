local _, ns = ...

local Condition = {}
Condition.__index = Condition

ns.trackers.createCondition = function()
	return setmetatable({
		changes = {},
		check = nil,
	}, Condition)
end
