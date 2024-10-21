local _, addon = ...

addon.load.CreateSpellKnownCondition = function(spellId, options)
	local o = options or {}

	local aura = {
		spellId = spellId,
	}

	aura.Serialize = function(self)
		return {
			use_spellknown = true,
			use_exact_spellknown = o.exact == true,
			spellknown = self.spellId,
		}
	end

	return aura
end
