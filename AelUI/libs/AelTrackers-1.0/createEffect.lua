local lib = LibStub('AelTrackers-1.0')

local Effect = {}
Effect.__index = Effect

lib.createEffect = function()
	return setmetatable({
		changes = {},
		check = nil,
	}, Effect)
end

function Effect:Apply()
	for _, change in ipairs(self.changes) do
		change:Apply()
	end
end

function Effect:ChangeColor(...)
	tinsert(self.changes, lib.effects.createChangeColor(...))
end

function Effect:ChangeDesaturate(...)
	tinsert(self.changes, lib.effects.createChangeDesaturate(...))
end

function Effect:CheckInRange(...)
	self.check = lib.effects.createCheckInRange(...)
end

function Effect:CheckOnCooldown(...)
	self.check = lib.effects.createCheckOnCooldown(...)
end

function Effect:Matches()
	return self.check == nil and false or self.check:Matches()
end
