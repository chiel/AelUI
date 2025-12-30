local _, ns = ...

local auraTypeMap = {
	both = 'BOTH',
	buff = 'HELPFUL',
	debuff = 'HARMFUL',
}

local showMap = {
	always = 'showAlways',
	onActive = 'showOnActive',
	onMatches = 'showOnMatches',
	onMissing = 'showOnMissing',
}

ns.triggers.CreateAura = function(unit, type, options)
	local o = options or {}

	local aura = {
		spellIds = o.spellIds,
		ownOnly = o.ownOnly,
		show = o.show,
		type = type,
		unit = unit,
	}

	aura.SetShow = function(self, show)
		self.show = show
	end

	aura.Serialize = function(self)
		local t = {
			type = 'aura2',
			unit = self.unit,
			debuffType = auraTypeMap[self.type],
			ownOnly = self.ownOnly,
			matchesShowOn = self.show ~= nil and showMap[self.show] or showMap.onActive,
		}

		if self.spellIds ~= nil then
			t.auraspellids = o.spellIds
			t.useExactSpellId = true
		end

		return { trigger = t, untrigger = {} }
	end

	return aura
end
