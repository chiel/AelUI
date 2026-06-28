local _, ns = ...

ns.load.CreateSpellKnownCondition = function(spellId, options)
	local o = options or {}

	local aura = {
		exact = o.exact,
		spellId = spellId,
	}

	aura.Serialize = function(self)
		local r = {
			use_spellknown = true,
			spellknown = aura.spellId,
		}

		if self.exact == true then r.use_exact_spellknown = true end

		return r
	end

	return aura
end
