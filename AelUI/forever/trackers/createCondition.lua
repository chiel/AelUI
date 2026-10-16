local _, ns = ...

local Condition = {}
Condition.__index = Condition

ns.trackers.createCondition = function()
	return setmetatable({
		changes = {},
		check = nil,
	}, Condition)
end

function Condition:Apply()
	for _, change in ipairs(self.changes) do
		change:Apply()
	end
end

function Condition:CheckOnCooldown(...)
	self.check = ns.trackers.conditions.createCheckOnCooldown(...)
end

function Condition:Matches()
	return self.check == nil and false or self.check:Matches()
end
