local AelEvents = LibStub('AelEvents-1.0')
local lib = LibStub('AelTrackers-1.0')

local AutoRepeatSpellProbe = {}
AutoRepeatSpellProbe.__index = AutoRepeatSpellProbe
setmetatable(AutoRepeatSpellProbe, { __index = lib.utils.Watchable })

lib.probes.createAutoRepeatSpellProbe = function(spellId)
	local probe = setmetatable({
		isRepeating = nil,
		spellId = spellId,
	}, AutoRepeatSpellProbe)

	probe:Update()
	return probe
end

function AutoRepeatSpellProbe:IsRepeating()
	return self.isRepeating
end

function AutoRepeatSpellProbe:OnWatch()
	AelEvents.on('START_AUTOREPEAT_SPELL', function()
		self:Update()
	end)

	AelEvents.on('STOP_AUTOREPEAT_SPELL', function()
		self:Update()
	end)

	self:Update()
end

function AutoRepeatSpellProbe:SpellId(spellId)
	self.spellId = spellId
	self:Update()
end

function AutoRepeatSpellProbe:Update()
	local isRepeating = C_Spell.IsAutoRepeatSpell(self.spellId)

	if isRepeating == self.isRepeating then
		return
	end

	self.isRepeating = isRepeating
	self:Notify(self.isRepeating)
end
