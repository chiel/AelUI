local _, ns = ...

local SpellCooldownTrigger = {}
SpellCooldownTrigger.__index = SpellCooldownTrigger
setmetatable(SpellCooldownTrigger, { __index = ns.trackers.triggers.BaseTrigger })

ns.trackers.triggers.createSpellCooldownTrigger = function(spellId, options)
	options = options or {}

	local trigger = setmetatable({
		state = { isOnCooldown = false },
		show = options.show or 'always',
		spellId = spellId,
	}, SpellCooldownTrigger)

	trigger:Init()
	trigger:Update()

	return trigger
end

function SpellCooldownTrigger:Apply(tracker)
	if tracker.display.icon then
		tracker.display.icon:Texture(C_Spell.GetSpellTexture(self.spellId))
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

	ns.events.on('SPELL_UPDATE_COOLDOWN', function(_, spellId)
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

function SpellCooldownTrigger:Update()
	local cd = C_Spell.GetSpellCooldown(self.spellId)

	if cd.isActive and not cd.isOnGCD then
		self.state.isOnCooldown = true
		local duration = C_Spell.GetSpellCooldownDuration(self.spellId)
		if self.expiry then
			self.expiry:SetCooldownFromDurationObject(duration)
		end
	else
		self.state.isOnCooldown = false
		if self.expiry then
			self.expiry:Clear()
		end
	end
end
