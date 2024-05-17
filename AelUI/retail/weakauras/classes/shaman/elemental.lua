local ns = select(2, ...)

local wa = ns.weakauras
local consumableIcon = wa.createConsumableIconBuilder
local itemIcon = wa.createItemIconBuilder
local spellIcon = wa.createSpellIconBuilder
local consumables = wa.consumables
local racials = wa.racials
local spells = wa.classes.shaman.spells

table.insert(ns.weakauras.classes.shaman.specs, {
	specId = 262, -- Elemental

	groups = {
		primary = {
			racials.bloodFury,
			spellIcon(198067), -- Fire Elemental
			spellIcon(192249), -- Storm Elemental
			spellIcon(210714), -- Icefury
			spellIcon(191634), -- Stormkeeper
			spells.elementalBlast,
			spells.primordialWave,
			spellIcon(114050), -- Ascendance
			spellIcon(192222), -- Liquid Magma Totem
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
