local _, ns = ...

ns.anchors.create = function(name)
	local anchor = CreateFrame('Frame', name, UIParent)
	return anchor
end
