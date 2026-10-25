local lib = LibStub('AelTrackers-1.0')

local SpellSource = {}
SpellSource.__index = SpellSource
setmetatable(SpellSource, { __index = lib.sources.BaseSource })

lib.sources.createSpell = function(spellId, options)
	options = options or {}

	local source = setmetatable({
		state = {},
		durations = options.durations or {},
		icon = options.icon,
		spellId = spellId,
	}, SpellSource)

	source:Init()

	return source
end

SpellSource.attributes = {
	range = {
		events = { 'PLAYER_TARGET_CHANGED', 'SPELL_RANGE_CHECK_UPDATE' },
		eventFilter = 'FilterRangeEvents',
	},
}

function SpellSource:Apply(tracker)
	local duration = self.cooldownProbe and self.cooldownProbe:Duration()

	for _, d in ipairs(self.durations) do
		d:Duration(duration)
	end

	if self.icon then
		self.icon:Texture(C_Spell.GetSpellTexture(self.spellId))
	end
end

function SpellSource:Build(tracker)
	if self.cooldownProbe then
		self.cooldownProbe:Watch(function()
			self:Notify()
		end)
	end

	if self:Requires('range') then
		C_Spell.EnableSpellRangeCheck(self.spellId, true)
	end

	self:RegisterAttributeEvents()
end

function SpellSource:FilterRangeEvents(event, ...)
	if event == 'PLAYER_TARGET_CHANGED' then
		return true
	end

	local spellId = ...
	return spellId == self.spellId
end

function SpellSource:IsInRange()
	return self.state.isInRange
end

function SpellSource:IsOnCooldown()
	return self.cooldownProbe:IsOnCooldown()
end

function SpellSource:RequireCooldown()
	if self.cooldownProbe then
		return
	end

	self.cooldownProbe = lib.probes.createSpellCooldownProbe(self.spellId)
end

function SpellSource:Update()
	if self:Requires('range') then
		local isInRange = C_Spell.IsSpellInRange(self.spellId)
		self.state.isInRange = isInRange
	end
end
