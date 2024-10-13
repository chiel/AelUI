local _, ns = ...

local secondaryResizer = ns.weakauras.createRegionResizer({
	'AelUI - Common - GCD',
})

ns.OnInitialise(function()
	ns.anchors.secondary:OnResize(function(width)
		secondaryResizer(width)
	end)
end)
