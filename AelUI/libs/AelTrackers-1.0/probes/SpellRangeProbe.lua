local AelEvents = LibStub('AelEvents-1.0')
local lib = LibStub('AelTrackers-1.0')

local SpellRangeProbe = {}
SpellRangeProbe.__index = SpellRangeProbe
setmetatable(SpellRangeProbe, { __index = lib.utils.Watchable })

lib.probes.createSpellRangeProbe = function(spellId)
	local probe = setmetatable({
		isInRange = nil,
		spellId = spellId,
	}, SpellRangeProbe)

	C_Spell.EnableSpellRangeCheck(spellId, true)

	probe:Update()
	return probe
end

function SpellRangeProbe:IsInRange()
	return self.isInRange
end

function SpellRangeProbe:OnWatch()
	AelEvents.on('PLAYER_TARGET_CHANGED', function()
		self:Update()
	end)

	AelEvents.on('SPELL_RANGE_CHECK_UPDATE', function(_, spellId)
		if spellId == self.spellId then
			self:Update()
		end
	end)
end

function SpellRangeProbe:SpellId(spellId)
	C_Spell.EnableSpellRangeCheck(spellId, true)
	self.spellId = spellId
	self:Update()
end

function SpellRangeProbe:Update()
	local isInRange = C_Spell.IsSpellInRange(self.spellId)

	if isInRange == self.isInRange then
		return
	end

	self.isInRange = isInRange
	self:Notify(self.isInRange)
end
