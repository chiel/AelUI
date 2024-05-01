local ns = select(2, ...)

ns.anchors = {}

function ns.anchors:Initialise()
	ns.anchors.primary:Initialise()
	ns.anchors.secondary:Initialise()
end
