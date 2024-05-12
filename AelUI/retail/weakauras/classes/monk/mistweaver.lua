local ns = select(2, ...)

local wa = ns.weakauras
local consumableIcon = wa.createConsumableIconBuilder
local itemIcon = wa.createItemIconBuilder
local spellIcon = wa.createSpellIconBuilder
local consumables = wa.consumables
local racials = wa.racials
local spells = wa.classes.monk.spells

table.insert(ns.weakauras.classes.monk.specs, {
	name = 'Mistweaver',
	icon = 608952,
	specId = 270,

	groups = {
		primary = {
			spellIcon(325197), -- Invoke Chi-Ji, the Red Crane,
			spellIcon(322118), -- Invoke Yu'lon, the Jade Serpent,
			spellIcon(116849), -- Life Cocoon,
			spellIcon(115310), -- Revival,
			spellIcon(124081), -- Zen Pulse,
			spellIcon(388193), -- Faeline Stomp,
			spellIcon(116680), -- Thunder Focus Tea,
			spellIcon(115151), -- Renewing Mist,
			spellIcon(107428), -- Rising Sun Kick,
			spellIcon(100784), -- Blackout Kick,
			spellIcon(322101), -- Expel Harm,
			spellIcon(399491), -- Sheilun's Gift,
			spellIcon(124682), -- Enveloping Mist,
			spellIcon(191837), -- Essence Font,
		},
		secondary = {
			spells.spearHandStrike,
			spells.legSweep,
			spells.paralysis,
			spells.ringOfPeace,
			-- spells.provoke,
			racials.arcaneTorrent,
			spells.touchOfDeath,
			spells.detox,
			spells.roll,
			spells.tigersLust,
			spells.transcendence,
			spells.transcendenceTransfer,
		},
		defensives = {
			spells.dampenHarm,
			spells.diffuseMagic,
			spells.fortifyingBrew,
		},
		consumables = {
			consumables.dreamwalkersHealingPotion,
			consumables.healthstone,
			consumables.elementalPotionOfUltimatePower,
			consumables.potionOfTheHushedZephyr,
		},
	},
})
