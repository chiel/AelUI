local lib = LibStub('AelTrackers-1.0')

local SpellSource = {}
SpellSource.__index = SpellSource
setmetatable(SpellSource, { __index = lib.utils.Watchable })

lib.sources.createSpell = function(spellId, options)
	options = options or {}

	local source = setmetatable({
		durations = options.durations or {},
		icon = options.icon,
		spellId = spellId,
	}, SpellSource)

	source.overrideProbe = lib.probes.createSpellOverrideProbe(spellId)

	return source
end

function SpellSource:Apply(tracker)
	local duration = self.cooldownProbe and self.cooldownProbe:Duration()

	for _, d in ipairs(self.durations) do
		d:Duration(duration)
	end

	if self.icon then
		self.icon:Texture(C_Spell.GetSpellTexture(self.overrideProbe:SpellId()))
	end
end

function SpellSource:Build(tracker)
	self.overrideProbe:Watch(function(spellId)
		if self.autoRepeatProbe then
			self.autoRepeatProbe:SpellId(spellId)
		end
		if self.cooldownProbe then
			self.cooldownProbe:SpellId(spellId)
		end
		if self.rangeProbe then
			self.rangeProbe:SpellId(spellId)
		end
		self:Notify()
	end)

	if self.autoRepeatProbe then
		self.autoRepeatProbe:Watch(function()
			self:Notify()
		end)
	end

	if self.cooldownProbe then
		self.cooldownProbe:Watch(function()
			self:Notify()
		end)
	end

	if self.rangeProbe then
		self.rangeProbe:Watch(function()
			self:Notify()
		end)
	end
end

function SpellSource:IsAutoRepeating()
	return self.autoRepeatProbe:IsRepeating()
end

function SpellSource:IsInRange()
	return self.rangeProbe:IsInRange()
end

function SpellSource:IsOnCooldown()
	return self.cooldownProbe:IsOnCooldown()
end

function SpellSource:RequireAutoRepeat()
	if self.autoRepeatProbe then
		return
	end

	local spellId = self.overrideProbe:SpellId()
	self.autoRepeatProbe = lib.probes.createAutoRepeatSpellProbe(spellId)
end

function SpellSource:RequireCooldown()
	if self.cooldownProbe then
		return
	end

	local spellId = self.overrideProbe:SpellId()
	self.cooldownProbe = lib.probes.createSpellCooldownProbe(spellId)
end

function SpellSource:RequireRange()
	if self.rangeProbe then
		return
	end

	local spellId = self.overrideProbe:SpellId()
	self.rangeProbe = lib.probes.createSpellRangeProbe(spellId)
end
