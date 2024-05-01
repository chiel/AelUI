local ns = select(2, ...)

local ac = ns.config.anchors
local ic = ns.config.icons
local wa = ns.weakauras

local primaryRegions = {
	{ name = 'AelUI - Power' },
}

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
