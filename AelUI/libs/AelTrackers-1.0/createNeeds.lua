local lib = LibStub('AelTrackers-1.0')

local Needs = {}
Needs.__index = Needs

lib.createNeeds = function()
	return setmetatable({ needs = {} }, Needs)
end

function Needs:Matches()
	for _, need in ipairs(self.needs) do
		if not need:Matches() then
			return false
		end
	end

	return true
end

function Needs:SpellKnown(...)
	local need = lib.needs.createSpellKnown(...)
	tinsert(self.needs, need)
	return need
end

function Needs:Watch(fn)
	for _, need in ipairs(self.needs) do
		need:Watch(fn)
	end
end
