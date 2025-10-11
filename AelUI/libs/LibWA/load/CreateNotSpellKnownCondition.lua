local _, addon = ...

addon.load.CreateNotSpellKnownCondition = function(spellId, options)
	local o = options or {}

	local aura = {
		spellId = spellId,
	}

	aura.Serialize = function(self)
		return {
			use_not_spellknown = true,
			use_exact_not_spellknown = o.exact == true,
			not_spellknown = self.spellId,
		}
	end

	return aura
end
