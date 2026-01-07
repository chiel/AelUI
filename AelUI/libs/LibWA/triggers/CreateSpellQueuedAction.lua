local _, ns = ...

ns.triggers.CreateSpellQueuedAction = function(spellName)
	local aura = {
		spellName = spellName,
	}

	aura.Serialize = function(self)
		local t = {
			type = 'spell',
			event = 'Queued Action',
			spellName = self.spellName,
		}

		return { trigger = t, untrigger = {} }
	end

	return aura
end
