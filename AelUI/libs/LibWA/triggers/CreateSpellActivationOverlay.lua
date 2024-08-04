local _, addon = ...

addon.triggers.CreateSpellActivationOverlay = function(spellName, options)
	local o = options or {}

	local aura = {
		table = {
			trigger = {
				type = 'spell',
				event = 'Spell Activation Overlay',
				spellName = spellName,
				use_exact_spellName = o.exact or false,
			},
			untrigger = {},
		},
	}

	aura.Serialize = function(self)
		return self.table
	end

	return aura
end
