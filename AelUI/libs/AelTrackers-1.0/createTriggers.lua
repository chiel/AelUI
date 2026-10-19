local lib = LibStub('AelTrackers-1.0')

local Triggers = {}
Triggers.__index = Triggers

lib.createTriggers = function()
	return setmetatable({ entries = {} }, Triggers)
end

function Triggers:Apply(tracker)
	local hasActiveTrigger = false
	for _, trigger in ipairs(self.entries) do
		if trigger:IsActive() then
			hasActiveTrigger = true
			trigger:Apply(tracker)
			break
		end
	end

	tracker:SetShown(hasActiveTrigger)
end

function Triggers:Build(tracker)
	for _, trigger in ipairs(self.entries) do
		trigger:Build(tracker)
	end
end

function Triggers:SpellCooldown(...)
	local trigger = lib.triggers.createSpellCooldownTrigger(...)
	tinsert(self.entries, trigger)
	return trigger
end

function Triggers:Spell(...)
	local trigger = lib.triggers.createSpellTrigger(...)
	tinsert(self.entries, trigger)
	return trigger
end

function Triggers:Update()
	for _, trigger in ipairs(self.entries) do
		trigger:Update()
	end
end

function Triggers:Watch(fn)
	for _, trigger in ipairs(self.entries) do
		trigger:Watch(fn)
	end
end
