local _, ns = ...

local secondaryResizer = ns.weakauras.createResizer({
	'Swing (Ranged) (AelUI - Common)',
})

ns.OnInitialise(function()
	ns.anchors.secondary:OnResize(function(width)
		secondaryResizer(width)
	end)
end)
