local _, ns = ...

local showMap = {
	always = 'showAlways',
	onCooldown = 'showOnCooldown',
	onReady = 'showOnReady',
}

ns.triggers.CreateSpellCooldown = function(spellName, options)
	local o = options or {}

	local aura = {
		spellName = spellName,
		show = o.show,
	}

	aura.SetShow = function(self, show)
		self.show = show
	end

	aura.Serialize = function(self)
		local t = {
			type = 'spell',
			event = 'Cooldown Progress (Spell)',
			spellName = self.spellName,
			genericShowOn = o.show ~= nil and showMap[o.show] or showMap.onCooldown,
		}

		return { trigger = t, untrigger = {} }
	end

	return aura
end
