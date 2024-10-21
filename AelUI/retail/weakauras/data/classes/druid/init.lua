local _, ns = ...

local wa = ns.weakauras
local spellIcon = wa.spellIcon

ns.weakauras.data.classes.druid = {
	name = 'Druid',
	icon = 625999,
	specs = {},

	spells = {
		barkskin = spellIcon(22812),
		charmWoodlandCreature = spellIcon(127757),
		dash = spellIcon(1850),
		growl = spellIcon(6795),
		incapacitatingRoar = spellIcon(99),
		innervate = spellIcon(29166),
		renewal = spellIcon(108238),
		soothe = spellIcon(2908),
		stampedingRoar = spellIcon(106898),
		typhoon = spellIcon(132469),
		ursolsVortex = spellIcon(102793),
	},
}
