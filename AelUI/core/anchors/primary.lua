local ns = select(2, ...)

local anchor = CreateFrame('Frame', 'AelUIPrimaryAnchor', UIParent)
anchor.Initialise = function()
	local c = ns.db.anchors.primary
	anchor:SetPoint('TOP', UIParent, 'CENTER', 0, -c.offset)
	anchor:SetSize(c.minWidth, ns.db.icons.primary.size)

	local updater = ns.anchors.createUpdater(anchor, c.minWidth)
	anchor.UpdateMinWidth = updater.SetMinWidth
	anchor.UpdateWidth = updater.SetWidth
end

ns.anchors.primary = anchor

AelUIPrimaryAnchor.GetMinimumWidth = function(self)
	return ns.db.anchors.primary.minWidth
end

AelUIPrimaryAnchor.SetMinimumWidth = function(self, width)
	ns.db.anchors.primary.minWidth = width
	anchor.UpdateMinWidth(width)
end

AelUIPrimaryAnchor.GetOffset = function(self)
	return ns.db.anchors.primary.offset
end

AelUIPrimaryAnchor.SetOffset = function(self, position)
	ns.db.anchors.primary.offset = position
	anchor:SetPoint('TOP', UIParent, 'CENTER', 0, -position)
end
