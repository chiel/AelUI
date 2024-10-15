local _, ns = ...

local anchors = ns.anchors
local wa = ns.weakauras

local pc = wa.config.primary.childConfig
local primary = wa.createGrower(pc.width, pc.height, 2, function(width)
	anchors.primary:UpdateWidth(width)
end)

local sc = wa.config.secondary.childConfig
local secondary = wa.createGrower(sc.width, sc.height, 2, function(width)
	anchors.secondary:UpdateWidth(width)
end)

AelUI.weakauras.growers = {
	primary = primary,
	secondary = secondary,
}

-- local ac = ns.config.anchors
-- local ic = ns.config.icons
-- local wa = ns.weakauras

-- local primaryRegions = {
-- 	{ name = 'AelUI - Power' },
-- }

-- local primaryRegionResizer = wa.createRegionResizer(ac.primary.minWidth, primaryRegions)

-- local primaryGrower = wa.createGrower(ic.primary.size, ic.spacing, function(width)
-- 	ns.anchors.primary.UpdateWidth(width)
-- 	primaryRegionResizer(width)
-- end)

-- local secondaryRegions = {
-- 	{ name = 'AelUI - GCD' },
-- }

-- local secondaryRegionResizer = wa.createRegionResizer(ac.secondary.minWidth, secondaryRegions)

-- local secondaryGrower = wa.createGrower(ic.secondary.size, ic.spacing, function(width)
-- 	ns.anchors.secondary.UpdateWidth(width)
-- 	secondaryRegionResizer(width)
-- end)

-- AelUI.weakauras.growers = {
-- 	primary = primaryGrower,
-- 	secondary = secondaryGrower,
-- }
