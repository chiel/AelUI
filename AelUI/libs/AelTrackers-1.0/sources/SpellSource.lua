local lib = LibStub('AelTrackers-1.0')

local SpellSource = {}
SpellSource.__index = SpellSource
setmetatable(SpellSource, { __index = lib.sources.BaseSource })

lib.sources.createSpell = function(spellId, options)
	options = options or {}

	local source = setmetatable({
		durations = options.durations or {},
		icon = options.icon,
		spellId = spellId,
	}, SpellSource)

	source:Init()

	return source
end

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

	if self.rangeProbe then
		self.rangeProbe:Watch(function()
			self:Notify()
		end)
	end
end

function SpellSource:IsInRange()
	return self.rangeProbe:IsInRange()
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

function SpellSource:RequireRange()
	if self.rangeProbe then
		return
	end

	self.rangeProbe = lib.probes.createSpellRangeProbe(self.spellId)
end
