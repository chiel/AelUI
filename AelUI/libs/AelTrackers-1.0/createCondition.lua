local lib = LibStub('AelTrackers-1.0')

local Condition = {}
Condition.__index = Condition

lib.createCondition = function()
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

function Condition:ChangeColor(...)
	tinsert(self.changes, lib.conditions.createChangeColor(...))
end

function Condition:ChangeDesaturate(...)
	tinsert(self.changes, lib.conditions.createChangeDesaturate(...))
end

function Condition:CheckInRange(...)
	self.check = lib.conditions.createCheckInRange(...)
end

function Condition:CheckOnCooldown(...)
	self.check = lib.conditions.createCheckOnCooldown(...)
end

function Condition:Matches()
	return self.check == nil and false or self.check:Matches()
end
