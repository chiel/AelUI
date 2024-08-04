local _, addon = ...

local showMap = {
	always = 'showAlways',
	onCooldown = 'showOnCooldown',
	onReady = 'showOnReady',
}

addon.triggers.CreateSpellCooldown = function(spellName, options)
	local o = options or {}

	local aura = {
		table = {
			trigger = {
				type = 'spell',
				event = 'Cooldown Progress (Spell)',
				spellName = spellName,
				genericShowOn = o.show ~= nil and showMap[o.show] or showMap.onCooldown,
			},
			untrigger = {},
		},
	}

	aura.Serialize = function(self)
		return self.table
	end

	return aura
end
