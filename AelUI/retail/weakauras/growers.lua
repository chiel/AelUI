local ns = select(2, ...)

local ac = ns.core.config.anchors
local ic = ns.core.config.icons
local wa = ns.core.weakauras

local primaryRegions = {
	{ name = 'AelUI - Power' },
}

local primaryRegionResizer = wa.createRegionResizer(ac.primary.minWidth, primaryRegions)

local primaryGrower = wa.createGrower(ic.primary.size, ic.spacing, function(width)
	ns.core.anchors.primary.UpdateWidth(width)
	primaryRegionResizer(width)
end)

local secondaryRegions = {
	{ name = 'AelUI - GCD' },
}

local secondaryRegionResizer = wa.createRegionResizer(ac.secondary.minWidth, secondaryRegions)

local secondaryGrower = wa.createGrower(ic.secondary.size, ic.spacing, function(width)
	ns.core.anchors.secondary.UpdateWidth(width)
	secondaryRegionResizer(width)
end)

AelUI.weakauras.growers = {
	primary = primaryGrower,
	secondary = secondaryGrower,
}
