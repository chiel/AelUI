local ns = select(2, ...)

local ac = ns.config.anchors
local ic = ns.config.icons
local wa = ns.weakauras

-- local playerClass = select(2, UnitClass('player'))

-- local primaryRegionsByClass = {
-- 	DEATHKNIGHT = {
-- 		{ name = 'AelUI - Death Knight - Runes', updateChildren = true },
-- 	},
-- 	DEMONHUNTER = {
-- 		{ name = 'AelUI - Demon Hunter - Vengeance - Soul Fragments' },
-- 	},
-- 	EVOKER = {
-- 		{ name = 'AelUI - Class - Evoker - Augmentation - Aura - Ebon Might' },
-- 		{ name = 'AelUI - Class - Evoker - Augmentation - Aura - Hover' },
-- 		{ name = 'AelUI - Class - Evoker - Devastation - Aura - Hover' },
-- 		{ name = 'AelUI - Evoker - Essence' },
-- 	},
-- 	MONK = {
-- 		{ name = 'AelUI - Class - Monk - Mistweaver - Aura - Ancient Teachings' },
-- 		{ name = 'AelUI - Monk - Windwalker - Chi' },
-- 	},
-- 	PALADIN = {
-- 		{ name = 'AelUI - Paladin - Holy Power' },
-- 	},
-- 	ROGUE = {
-- 		{ name = 'AelUI - Rogue - Combo Points' },
-- 	},
-- 	SHAMAN = {
-- 		{ name = 'AelUI - Shaman - Enhancement - Maelstrom Weapon' },
-- 	},
-- 	WARLOCK = {
-- 		{ name = 'AelUI - Warlock - Soul Shards' },
-- 	},
-- 	WARRIOR = {
-- 		{ name = 'AelUI - Warrior - Fury - Enrage buff' },
-- 		{ name = 'AelUI - Warrior - Protection - Shield Block buff' },
-- 	},
-- }

local primaryRegions = {
	{ name = 'AelUI - Power' },
}

-- tAppendAll(primaryRegions, primaryRegionsByClass[playerClass] or {})
local primaryRegionResizer = wa.createRegionResizer(ac.primary.minWidth, primaryRegions)

local primaryGrower = wa.createGrower(ic.primary.size, ic.spacing, function(width)
	ns.anchors.primary.UpdateWidth(width)
	primaryRegionResizer(width)
end)

local secondaryRegions = {
	{ name = 'AelUI - GCD' },
}

local secondaryRegionResizer = wa.createRegionResizer(ac.secondary.minWidth, secondaryRegions)

local secondaryGrower = wa.createGrower(ic.secondary.size, ic.spacing, function(width)
	ns.anchors.secondary.UpdateWidth(width)
	secondaryRegionResizer(width)
end)

AelUI.weakauras.growers = {
	primary = primaryGrower,
	secondary = secondaryGrower,
}
