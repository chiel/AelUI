local ns = select(2, ...)

local wa = ns.weakauras
local itemIcon = wa.createItemIconBuilder
local spellIcon = wa.createSpellIconBuilder
local consumables = wa.consumables
local spells = wa.classes.paladin.spells

table.insert(ns.weakauras.classes.paladin.specs, {
	name = 'Retribution',
	icon = 135873,
	specId = 70,

	groups = {
		primary = {
			spells.avengingWrath,
			spellIcon(343721), -- Final Reckoning
			spellIcon(343527), -- Execution Sentence
			spells.divineToll,
			spellIcon(255937), -- Wake of Ashes
			spells.hammerOfWrath,
			spells.judgment,
			spellIcon(184575), -- Blade of Justice
		},
		secondary = {
			spells.rebuke,
			spells.hammerOfJustice,
			spells.blindingLight,
			spells.divineSteed,
			spells.handOfReckoning,
			spells.cleanseToxins,
			spells.blessingOfFreedom,
			spells.blessingOfProtection,
			spells.blessingOfSacrifice,
		},
		defensives = {
			spells.layOnHands,
			spells.divineShield,
			spellIcon(184662), -- Shield of Vengeance
			spellIcon(403876), -- Divine Protection
		},
		consumables = {
			consumables.dreamwalkersHealingPotion,
			consumables.healthstone,
			consumables.elementalPotionOfUltimatePower,
			consumables.potionOfTheHushedZephyr,
		},
	},
})
