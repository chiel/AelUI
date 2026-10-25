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
	cooldown = {
		events = { 'SPELL_UPDATE_COOLDOWN' },
		eventFilter = 'FilterCooldownEvents',
	},
	range = {
		events = { 'PLAYER_TARGET_CHANGED', 'SPELL_RANGE_CHECK_UPDATE' },
		eventFilter = 'FilterRangeEvents',
	},
}

function SpellSource:Apply(tracker)
	for _, d in ipairs(self.durations) do
		d:Duration(self.duration)
	end

	if self.icon then
		self.icon:Texture(C_Spell.GetSpellTexture(self.spellId))
	end
end

function SpellSource:Build(tracker)
	if self:Requires('cooldown') then
		self.cdTracker = CreateFrame('Cooldown', nil, WorldFrame)
		self.cdTracker:SetSize(1, 1)
		self.cdTracker:SetAlpha(0)
		self.cdTracker:Show()
		self.cdTracker:SetScript('OnCooldownDone', function()
			C_Timer.After(0, function()
				self:Update()
				self:Notify()
			end)
		end)
	end

	if self:Requires('range') then
		C_Spell.EnableSpellRangeCheck(self.spellId, true)
	end

	self:RegisterAttributeEvents()
end

function SpellSource:FilterCooldownEvents(_, spellId)
	return spellId == self.spellId
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
	return self.state.isOnCooldown
end

function SpellSource:Update()
	if self:Requires('cooldown') then
		local cd = C_Spell.GetSpellCooldown(self.spellId)

		if cd.isActive and not cd.isOnGCD then
			self.duration = C_Spell.GetSpellCooldownDuration(self.spellId)
			self.state.isOnCooldown = true
			if self.cdTracker then
				self.cdTracker:SetCooldownFromDurationObject(self.duration)
			end
		else
			self.duration = nil
			self.state.isOnCooldown = false
			if self.cdTracker then
				self.cdTracker:Clear()
			end
		end
	end

	if self:Requires('range') then
		local isInRange = C_Spell.IsSpellInRange(self.spellId)
		self.state.isInRange = isInRange
	end
end
