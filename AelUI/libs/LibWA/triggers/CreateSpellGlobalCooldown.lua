local _, addon = ...

addon.triggers.CreateSpellGlobalCooldown = function(options)
	local o = options or {}

	local aura = {
		table = {
			trigger = {
				type = 'spell',
				event = 'Global Cooldown',
			},
			untrigger = {},
		},
	}

	aura.Serialize = function(self)
		return self.table
	end

	return aura
end
