local lib = LibStub('AelTrackers-1.0')

local SpellTrigger = {}
SpellTrigger.__index = SpellTrigger
setmetatable(SpellTrigger, { __index = lib.triggers.BaseTrigger })

lib.triggers.createSpellTrigger = function(spellId, options)
	options = options or {}

	local trigger = setmetatable({
		state = {},
		icon = options.icon,
		spellId = spellId,
	}, SpellTrigger)

	trigger:Init()

	return trigger
end

SpellTrigger.attributes = {
	range = {
		events = { 'PLAYER_TARGET_CHANGED', 'SPELL_RANGE_CHECK_UPDATE' },
		eventFilter = 'FilterRangeEvents',
	},
}

function SpellTrigger:Apply(tracker)
	if self.icon then
		icon:Texture(C_Spell.GetSpellTexture(self.spellId))
	end
end

function SpellTrigger:Build(tracker)
	if self:Requires('range') then
		C_Spell.EnableSpellRangeCheck(self.spellId, true)
	end

	self:RegisterAttributeEvents()
end

function SpellTrigger:FilterRangeEvents(event, ...)
	if event == 'PLAYER_TARGET_CHANGED' then
		return true
	end

	local spellId = ...
	return spellId == self.spellId
end

function SpellTrigger:IsActive()
	return true
end

function SpellTrigger:IsInRange()
	return self.state.isInRange
end

function SpellTrigger:Update()
	if self:Requires('range') then
		local isInRange = C_Spell.IsSpellInRange(self.spellId)
		self.state.isInRange = isInRange
	end
end
