local ns = select(2, ...)

local wa = ns.weakauras
local spellIcon = wa.createSpellIconBuilder

ns.weakauras.classes.shaman = {
	name = 'Shaman',
	icon = 626006,
	specs = {},

	spells = {
		ancestralGuidance = spellIcon(108281),
		astralShift = spellIcon(108271),
		capacitorTotem = spellIcon(192058),
		cleanseSpirit = spellIcon(51886),
		earthElemental = spellIcon(198103),
		earthbindTotem = spellIcon(2484),
		earthgrabTotem = spellIcon(51485),
		elementalBlast = spellIcon(117014),
		flameShock = spellIcon(188389),
		greaterPurge = spellIcon(378773),
		gustOfWind = spellIcon(192063),
		healingStreamTotem = spellIcon(5394),
		hex = spellIcon(51514),
		lavaBurst = spellIcon(51505),
		lightningLasso = spellIcon(305483),
		naturesSwiftness = spellIcon(378081),
		poisonCleansingTotem = spellIcon(383013),
		primordialWave = spellIcon(375982),
		purge = spellIcon(370),
		spiritWalk = spellIcon(58875),
		spiritwalkersGrace = spellIcon(79206),
		stoneskinTotem = spellIcon(383017),
		thunderstorm = spellIcon(51490),
		totemicProjection = spellIcon(108287),
		totemicRecall = spellIcon(108285),
		tranquilAirTotem = spellIcon(383019),
		tremorTotem = spellIcon(8143),
		windRushTotem = spellIcon(192077),
		windShear = spellIcon(57994),
	},
}
