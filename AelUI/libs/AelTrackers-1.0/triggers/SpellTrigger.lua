local lib = LibStub('AelTrackers-1.0')

local SpellTrigger = {}
SpellTrigger.__index = SpellTrigger
setmetatable(SpellTrigger, { __index = lib.triggers.BaseTrigger })

lib.triggers.createSpellTrigger = function(spellId, options)
	options = options or {}

	local trigger = setmetatable({
		state = {},
		durations = options.durations or {},
		icon = options.icon,
		spellId = spellId,
	}, SpellTrigger)

	trigger:Init()

	return trigger
end

SpellTrigger.attributes = {
	cooldown = {
		events = { 'SPELL_UPDATE_COOLDOWN' },
		eventFilter = 'FilterCooldownEvents',
	},
	range = {
		events = { 'PLAYER_TARGET_CHANGED', 'SPELL_RANGE_CHECK_UPDATE' },
		eventFilter = 'FilterRangeEvents',
	},
}

function SpellTrigger:Apply(tracker)
	for _, d in ipairs(self.durations) do
		d:Duration(self.duration)
	end

	if self.icon then
		self.icon:Texture(C_Spell.GetSpellTexture(self.spellId))
	end
end

function SpellTrigger:Build(tracker)
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

function SpellTrigger:FilterCooldownEvents(_, spellId)
	return spellId == self.spellId
end

function SpellTrigger:FilterRangeEvents(event, ...)
	if event == 'PLAYER_TARGET_CHANGED' then
		return true
	end

	local spellId = ...
	return spellId == self.spellId
end

function SpellTrigger:IsInRange()
	return self.state.isInRange
end

function SpellTrigger:IsOnCooldown()
	return self.state.isOnCooldown
end

function SpellTrigger:Update()
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
