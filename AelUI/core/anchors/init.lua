local ns = select(2, ...)

ns.core.anchors = {}

function ns.core.anchors:Initialise()
	ns.core.anchors.primary:Initialise()
	ns.core.anchors.secondary:Initialise()
end
