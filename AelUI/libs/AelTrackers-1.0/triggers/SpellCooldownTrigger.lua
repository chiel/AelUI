local lib = LibStub('AelTrackers-1.0')
local AelEvents = LibStub('AelEvents-1.0')

local SpellCooldownTrigger = {}
SpellCooldownTrigger.__index = SpellCooldownTrigger
setmetatable(SpellCooldownTrigger, { __index = lib.triggers.BaseTrigger })

lib.triggers.createSpellCooldownTrigger = function(spellId, options)
	options = options or {}

	local trigger = setmetatable({
		state = { isOnCooldown = false },
		durations = options.durations,
		icon = options.icon,
		show = options.show or 'always',
		spellId = spellId,
	}, SpellCooldownTrigger)

	trigger:Init()

	return trigger
end

function SpellCooldownTrigger:Apply(tracker)
	for _, d in ipairs(self.durations) do
		d:Duration(self.cooldownDuration)
	end

	if self.icon then
		self.icon:Texture(C_Spell.GetSpellTexture(self.spellId))
	end
end

function SpellCooldownTrigger:Build(tracker)
	self.expiry = CreateFrame('Cooldown', nil, WorldFrame)
	self.expiry:SetSize(1, 1)
	self.expiry:SetAlpha(0)
	self.expiry:Show()
	self.expiry:SetScript('OnCooldownDone', function()
		C_Timer.After(0, function()
			self:Update()
			self:Notify()
		end)
	end)

	AelEvents.on('SPELL_UPDATE_COOLDOWN', function(_, spellId)
		if spellId ~= self.spellId then
			return
		end

		self:Update()
		self:Notify()
	end)
end

function SpellCooldownTrigger:IsActive()
	if self.show == 'always' then
		return true
	end

	if self.show == 'onCooldown' and self.state.isOnCooldown then
		return true
	end

	if self.show == 'onReady' and not self.state.isOnCooldown then
		return true
	end

	return false
end

function SpellCooldownTrigger:IsOnCooldown()
	return self.state.isOnCooldown
end

function SpellCooldownTrigger:Update()
	local cd = C_Spell.GetSpellCooldown(self.spellId)

	if cd.isActive and not cd.isOnGCD then
		self.cooldownDuration = C_Spell.GetSpellCooldownDuration(self.spellId)
		self.state.isOnCooldown = true
		if self.expiry then
			self.expiry:SetCooldownFromDurationObject(self.cooldownDuration)
		end
	else
		self.cooldownDuration = nil
		self.state.isOnCooldown = false
		if self.expiry then
			self.expiry:Clear()
		end
	end
end
