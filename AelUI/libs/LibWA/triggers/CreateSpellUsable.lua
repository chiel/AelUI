local _, ns = ...

ns.triggers.CreateSpellUsable = function(spellName, options)
	local o = options or {}

	local aura = {
		spellName = spellName,
		ignoreCooldown = o.ignoreCooldown,
	}

	aura.Serialize = function(self)
		local t = {
			type = 'spell',
			event = 'Action Usable',
			spellName = self.spellName,
		}

		if self.ignoreCooldown then
			t.use_ignoreSpellCooldown = true
		end

		return { trigger = t, untrigger = {} }
	end

	return aura
end
