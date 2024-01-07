local addon = select(2, ...)

local anchors = addon.core.anchors
local config = addon.core.config
local ac = config.anchors
local ic = config.icons
local wa = addon.core.weakauras

local playerClass = select(2, UnitClass('player'))

local primaryRegionsByClass = {
	DEATHKNIGHT = {
		{ name = 'AelUI - Death Knight - Runes', updateChildren = true },
	},
	DEMONHUNTER = {
		{ name = 'AelUI - Demon Hunter - Vengeance - Soul Fragments' },
	},
	EVOKER = {
		{ name = 'AelUI - Class - Evoker - Augmentation - Aura - Ebon Might' },
		{ name = 'AelUI - Class - Evoker - Augmentation - Aura - Hover' },
		{ name = 'AelUI - Class - Evoker - Devastation - Aura - Hover' },
		{ name = 'AelUI - Evoker - Essence' },
	},
	MONK = {
		{ name = 'AelUI - Class - Monk - Mistweaver - Aura - Ancient Teachings' },
		{ name = 'AelUI - Monk - Windwalker - Chi' },
	},
	PALADIN = {
		{ name = 'AelUI - Paladin - Holy Power' },
	},
	ROGUE = {
		{ name = 'AelUI - Rogue - Combo Points' },
	},
	SHAMAN = {
		{ name = 'AelUI - Shaman - Enhancement - Maelstrom Weapon' },
	},
	WARLOCK = {
		{ name = 'AelUI - Warlock - Soul Shards' },
	},
	WARRIOR = {
		{ name = 'AelUI - Warrior - Fury - Enrage buff' },
		{ name = 'AelUI - Warrior - Protection - Shield Block buff' },
	},
}

local primaryRegions = {
	{ name = 'AelUI - Power' },
}

local secondaryRegions = {
	{ name = 'AelUI - GCD' },
}

tAppendAll(primaryRegions, primaryRegionsByClass[playerClass] or {})
local primaryRegionResizer = wa.createRegionResizer(ac.primary.minWidth, primaryRegions)

local secondaryRegionResizer = wa.createRegionResizer(ac.secondary.minWidth, secondaryRegions)

AelUI.weakauras.growers = {}

AelUI.weakauras.growers.primary = wa.createGrower(ic.primary.size, ic.spacing, function(width)
	anchors.primary.UpdateWidth(width)
	primaryRegionResizer(width)
end)

AelUI.weakauras.growers.secondary = wa.createGrower(ic.secondary.size, ic.spacing, function(width)
	anchors.secondary.UpdateWidth(width)
	secondaryRegionResizer(width)
end)
