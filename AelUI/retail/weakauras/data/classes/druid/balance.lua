local _, ns = ...

local wa = ns.weakauras
local reminderIcon = wa.reminderIcon
local spellIcon = wa.spellIcon
local spells = wa.data.classes.druid.spells

table.insert(ns.weakauras.data.classes.druid.specs, {
	specId = 102, -- Balance

	groups = {
		primary = {
			spellIcon(383410), -- Celestial Alignment
			spellIcon(391528), -- Convoke the Spirits
			spellIcon(205636), -- Force of Nature
			spellIcon(202425), -- Warrior of Elune
			spellIcon(202770), -- Fury of Elune
			spellIcon(274281), -- New Moon
			spellIcon(190984), -- Wrath
			spellIcon(194153), -- Starfire
			spellIcon(78674), -- Starsurge
			spellIcon(191034), -- Starfall
		},
		secondary = {
			spellIcon(78675), -- Solar Beam
			spells.typhoon,
			spells.ursolsVortex,
			spells.incapacitatingRoar,

			spells.charmWoodlandCreature,

			spells.dash,
			spellIcon(102383), -- Wild Charge
			spells.stampedingRoar,

			spells.growl,
			spells.innervate,
			spells.soothe,
		},
		defensives = {
			spellIcon(22842), -- Frenzied Regeneration
			spellIcon(124974), -- Nature's Vigil
			spells.renewal,
			spells.barkskin,
		},
		reminders = {
			reminderIcon(1126), -- Mark of the Wild
		},
	},
})
