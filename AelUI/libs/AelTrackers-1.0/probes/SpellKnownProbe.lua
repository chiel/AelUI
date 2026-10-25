local AelEvents = LibStub('AelEvents-1.0')
local lib = LibStub('AelTrackers-1.0')

local SpellKnownProbe = {}
SpellKnownProbe.__index = SpellKnownProbe
setmetatable(SpellKnownProbe, { __index = lib.utils.Watchable })

lib.probes.createSpellKnownProbe = function(spellId)
	local probe = setmetatable({
		isKnown = nil,
		spellId = spellId,
	}, SpellKnownProbe)

	probe:Update()
	return probe
end

function SpellKnownProbe:IsKnown()
	return self.isKnown
end

function SpellKnownProbe:OnWatch()
	AelEvents.on('SPELLS_CHANGED', function()
		self:Update()
	end)
end

function SpellKnownProbe:Update()
	local isKnown = C_SpellBook.IsSpellKnown(self.spellId)

	if isKnown == self.isKnown then
		return
	end

	self.isKnown = isKnown
	self:Notify(self.isKnown)
end
