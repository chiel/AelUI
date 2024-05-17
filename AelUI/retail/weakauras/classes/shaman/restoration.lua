local ns = select(2, ...)

local wa = ns.weakauras
local consumableIcon = wa.createConsumableIconBuilder
local itemIcon = wa.createItemIconBuilder
local spellIcon = wa.createSpellIconBuilder
local consumables = wa.consumables
local racials = wa.racials
local spells = wa.classes.shaman.spells

table.insert(ns.weakauras.classes.shaman.specs, {
	specId = 264, -- Restoration

	groups = {
		primary = {
			racials.bloodFury,
			spellIcon(61295), -- Riptide
			spellIcon(73920), -- Healing Rain
			spellIcon(383009), -- Stormkeeper
			spellIcon(98008), -- Spirit Link Totem
			spellIcon(108280), -- Healing Tide Totem
			spellIcon(16191), -- Mana Tide Totem
			spellIcon(73685), -- Unleash Life
			spellIcon(198838), -- Earthen Wall Totem
			spellIcon(207399), -- Ancestral Protection Totem
			spellIcon(428332), -- Primordial Wave
			spellIcon(207778), -- Downpour
			spellIcon(114052), -- Ascendance
			spellIcon(197995), -- Wellspring
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
