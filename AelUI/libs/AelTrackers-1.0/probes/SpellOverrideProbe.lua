local AelEvents = LibStub('AelEvents-1.0')
local lib = LibStub('AelTrackers-1.0')

local SpellOverrideProbe = {}
SpellOverrideProbe.__index = SpellOverrideProbe
setmetatable(SpellOverrideProbe, { __index = lib.utils.Watchable })

lib.probes.createSpellOverrideProbe = function(spellId)
	local probe = setmetatable({
		spellId = spellId,
	}, SpellOverrideProbe)

	probe:Update()
	return probe
end

function SpellOverrideProbe:SpellId()
	return self.overrideSpellId or self.spellId
end

function SpellOverrideProbe:OnWatch()
	AelEvents.on('SPELLS_CHANGED', function()
		self:Update()
	end)

	self:Update()
end

function SpellOverrideProbe:Update()
	local baseSpellId = C_Spell.GetBaseSpell(self.spellId)
	local overrideSpellId = C_Spell.GetOverrideSpell(baseSpellId)

	if overrideSpellId == self.overrideSpellId then
		return
	end

	self.overrideSpellId = overrideSpellId
	self:Notify(self:SpellId())
end
