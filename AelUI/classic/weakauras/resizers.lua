local _, ns = ...

local secondaryResizer = ns.weakauras.createResizer({
	'Swing (AelUI - Common)',
})

ns.OnInitialise(function()
	ns.anchors.secondary:OnResize(function(width)
		secondaryResizer(width)
	end)
end)
