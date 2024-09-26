local _, ns = ...

local wa = ns.weakauras
local spellIcon = wa.spellIcon
local spells = wa.data.classes.shaman.spells

table.insert(ns.weakauras.data.classes.shaman.specs, {
	specId = 264, -- Restoration

	groups = {
		primary = {
			spells.lavaBurst,
			spells.flameShock,
			spells.naturesSwiftness,
			spells.totemicRecall,
			spells.frostShock,
			spellIcon(207399), -- Ancestral Protection Totem
			spellIcon(114052), -- Ascendance
			spellIcon(198838), -- Earthen Wall Totem
			spellIcon(382021), -- Earthliving Weapon
			spellIcon(73920), -- Healing Rain
			spells.healingStreamTotem,
			spellIcon(108280), -- Healing Tide Totem
			spellIcon(77472), -- Healing Wave
			spellIcon(16191), -- Mana Tide Totem
			spellIcon(428332), -- Primordial Wave
			spellIcon(61295), -- Riptide
			spellIcon(98008), -- Spirit Link Totem
			spellIcon(73685), -- Unleash Life
			spellIcon(197995), -- Wellspring
		},
		secondary = {
			spells.windShear,
			spells.lightningLasso,
			spells.capacitorTotem,
			spells.thunderstorm,
			spells.earthbindTotem,
			spells.earthgrabTotem,
			spells.hex,

			spellIcon(77130), -- Purify Spirit
			spells.greaterPurge,
			spells.purge,
			spells.poisonCleansingTotem,
			spells.tremorTotem,

			spells.gustOfWind,
			spells.spiritWalk,
			spells.spiritwalkersGrace,
			spells.windRushTotem,

			spells.totemicProjection,
		},
		defensives = {
			spells.stoneBulwarkTotem,
			spells.earthElemental,
			spells.ancestralGuidance,
			spells.astralShift,
		},
		tracking = {},
	},
})
