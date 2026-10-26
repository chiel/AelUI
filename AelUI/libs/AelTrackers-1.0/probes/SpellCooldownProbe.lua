local AelEvents = LibStub('AelEvents-1.0')
local lib = LibStub('AelTrackers-1.0')

local SpellCooldownProbe = {}
SpellCooldownProbe.__index = SpellCooldownProbe
setmetatable(SpellCooldownProbe, { __index = lib.utils.Watchable })

lib.probes.createSpellCooldownProbe = function(spellId)
	local probe = setmetatable({
		isOnCooldown = nil,
		spellId = spellId,
	}, SpellCooldownProbe)

	probe:Update()
	return probe
end

function SpellCooldownProbe:Duration()
	return self.duration
end

function SpellCooldownProbe:IsOnCooldown()
	return self.isOnCooldown
end

function SpellCooldownProbe:OnWatch()
	self.tracker = CreateFrame('Cooldown', nil, WorldFrame)
	self.tracker:SetSize(1, 1)
	self.tracker:SetAlpha(0)
	self.tracker:Show()
	self.tracker:SetScript('OnCooldownDone', function()
		C_Timer.After(0, function()
			self:Update()
		end)
	end)

	AelEvents.on('SPELL_UPDATE_COOLDOWN', function(_, spellId)
		if spellId == self.spellId then
			self:Update()
		end
	end)

	self:Update()
end

function SpellCooldownProbe:SpellId(spellId)
	self.spellId = spellId
	self:Update()
end

function SpellCooldownProbe:Update()
	local cd = C_Spell.GetSpellCooldown(self.spellId)
	local isOnCooldown = cd.isActive and not cd.isOnGCD
	if isOnCooldown then
		self.duration = C_Spell.GetSpellCooldownDuration(self.spellId)
		if self.tracker then
			self.tracker:SetCooldownFromDurationObject(self.duration)
		end
	else
		self.duration = nil
		if self.tracker then
			self.tracker:Clear()
		end
	end

	if isOnCooldown == self.isOnCooldown then
		return
	end

	self.isOnCooldown = isOnCooldown
	self:Notify(self.isOnCooldown)
end
