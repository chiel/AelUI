local lib = LibStub('AelTrackers-1.0')

local SpellKnownNeed = {}
SpellKnownNeed.__index = SpellKnownNeed
setmetatable(SpellKnownNeed, { __index = lib.utils.Watchable })

lib.needs.createSpellKnown = function(spellId, expected)
	local probe = lib.probes.createSpellKnownProbe(spellId)

	local need = setmetatable({
		expected = expected,
		probe = probe,
	}, SpellKnownNeed)

	need:Update(probe:IsKnown())

	return need
end

function SpellKnownNeed:Matches()
	return self.matches
end

function SpellKnownNeed:OnWatch()
	self.probe:Watch(function(...)
		self:Update(...)
	end)
end

function SpellKnownNeed:Update(isKnown)
	local matches = isKnown == self.expected

	if matches == self.matches then
		return
	end

	self.matches = matches
	self:Notify(self.matches)
end
