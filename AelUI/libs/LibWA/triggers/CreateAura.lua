local addon = select(2, ...)

local debuffTypeMap = {
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

addon.triggers.CreateAura = function(unit, type, options)
	local o = options or {}

	local aura = {
		table = {
			trigger = {
				type = 'aura2',
				unit = unit,
				debuffType = debuffTypeMap[type],
				ownOnly = o.ownOnly,
				matchesShowOn = o.show ~= nil and showMap[o.show] or showMap.onActive,
			},
			untrigger = {},
		},
	}

	if o.exactSpellIds ~= nil then
		aura.table.trigger.auraspellids = o.exactSpellIds
		aura.table.trigger.useExactSpellId = true
	end

	aura.SetShow = function(self, show)
		aura.table.trigger.matchesShowOn = show ~= nil and showMap[show] or showMap.onActive
	end

	aura.Serialize = function(self)
		return self.table
	end

	return aura
end
