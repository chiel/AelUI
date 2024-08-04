local _, addon = ...

addon.load.CreateSpellKnownCondition = function(spellId)
	local aura = {
		spellId = spellId,
	}

	aura.Serialize = function(self)
		return {
			use_spellknown = true,
			spellknown = self.spellId,
		}
	end

	return aura
end
