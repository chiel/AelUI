local _, ns = ...

local wa = ns.weakauras
local spellIcon = wa.spellIcon
local spells = wa.data.classes.shaman.spells

table.insert(ns.weakauras.data.classes.shaman.specs, {
	specId = 263, -- Enhancement

	groups = {
		primary = {
			spellIcon(114051), -- Ascendance
			spellIcon(51533), -- Feral Spirit
			spellIcon(384352), -- Doom Winds
			spellIcon(197214), -- Sundering
			spellIcon(375982), -- Primordial Wave
			spellIcon(187874), -- Crash Lightning
			spells.flameShock,
			spellIcon(342240), -- Ice Strike
			spells.primalStrike,
			spellIcon(60103), -- Lava Lash
			spells.frostShock,
			spells.lavaBurst,
			spells.naturesSwiftness,
			spellIcon(117014), -- Elemental Blast
			spellIcon(333974), -- Fire Nova
		},
		secondary = {
			spells.windShear,
			spells.lightningLasso,
			spells.capacitorTotem,
			spells.thunderstorm,
			spells.earthbindTotem,
			spells.earthgrabTotem,
			spells.hex,

			spells.purge,
			spells.greaterPurge,
			spells.cleanseSpirit,
			spells.poisonCleansingTotem,

			spells.gustOfWind,
			spells.spiritWalk,
			spells.spiritwalkersGrace,
			spells.totemicProjection,
			spells.totemicRecall,
			spells.tremorTotem,
			spells.windRushTotem,
			spellIcon(196884), -- Feral Lunge
		},
		defensives = {
			spells.stoneBulwarkTotem,
			spells.healingStreamTotem,
			spells.earthElemental,
			spells.ancestralGuidance,
			spells.astralShift,
		},
		tracking = {},
	},
})
