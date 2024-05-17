local ns = select(2, ...)

local wa = ns.weakauras
local consumableIcon = wa.createConsumableIconBuilder
local itemIcon = wa.createItemIconBuilder
local spellIcon = wa.createSpellIconBuilder
local consumables = wa.consumables
local racials = wa.racials
local spells = wa.classes.shaman.spells

table.insert(ns.weakauras.classes.shaman.specs, {
	specId = 263, -- Enhancement

	groups = {
		primary = {
			racials.bloodFury,
			spellIcon(114051), -- Ascendance
			spellIcon(51533), -- Feral Spirit
			spellIcon(384352), -- Doom Winds
			spellIcon(197214), -- Sundering
			spellIcon(187874), -- Crash Lightning
			spellIcon(17364), -- Stormstrike
			spellIcon(60103), -- Lava Lash
			spellIcon(342240), -- Ice Strike
			spellIcon(333974), -- Fire Nova
			spellIcon(196884), -- Feral Lunge
			spells.primordialWave,
			spells.flameShock,
			spells.lavaBurst,
			spells.naturesSwiftness,
			spells.totemicRecall,
		},
		secondary = {
			spells.windShear,
			spells.capacitorTotem,
			spells.earthbindTotem,
			spells.earthgrabTotem,
			spells.hex,
			spells.lightningLasso,
			spells.thunderstorm,

			spells.gustOfWind,
			spells.spiritWalk,
			spells.spiritwalkersGrace,
			spells.windRushTotem,

			spells.purge,
			spells.greaterPurge,
			spells.cleanseSpirit,

			spells.healingStreamTotem,
			spells.poisonCleansingTotem,
			spells.tranquilAirTotem,
			spells.tremorTotem,

			spells.totemicProjection,
		},
		defensives = {
			spells.ancestralGuidance,
			spells.astralShift,
			spells.earthElemental,
			spells.stoneskinTotem,
		},
		consumables = {
			consumables.dreamwalkersHealingPotion,
			consumables.healthstone,
			consumables.elementalPotionOfUltimatePower,
			consumables.potionOfShockingDisclosure,
			consumables.potionOfTheHushedZephyr,
		},
	},
})
