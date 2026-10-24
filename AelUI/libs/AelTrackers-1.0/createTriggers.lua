local lib = LibStub('AelTrackers-1.0')

local Triggers = {}
Triggers.__index = Triggers

lib.createTriggers = function()
	return setmetatable({ entries = {} }, Triggers)
end

function Triggers:Apply(tracker)
	for _, trigger in ipairs(self.entries) do
		if trigger.Apply then
			trigger:Apply(tracker)
		end
	end
end

function Triggers:Aura(...)
	local trigger = lib.triggers.createAuraTrigger(...)
	tinsert(self.entries, trigger)
	return trigger
end

function Triggers:Build(tracker)
	for _, trigger in ipairs(self.entries) do
		trigger:Build(tracker)
	end
end

function Triggers:Spell(...)
	local trigger = lib.triggers.createSpellTrigger(...)
	tinsert(self.entries, trigger)
	return trigger
end

function Triggers:Update()
	for _, trigger in ipairs(self.entries) do
		if trigger.Update then
			trigger:Update()
		end
	end
end

function Triggers:Watch(fn)
	for _, trigger in ipairs(self.entries) do
		trigger:Watch(fn)
	end
end
