local ns = select(2, ...)

local anchor = CreateFrame('Frame', 'AelUIPrimaryAnchor', UIParent)
anchor.Initialise = function()
	local c = ns.core.db.anchors.primary
	anchor:SetPoint('TOP', UIParent, 'CENTER', 0, -c.offset)
	anchor:SetSize(c.minWidth, ns.core.db.icons.primary.size)

	local updater = ns.core.anchors.createUpdater(anchor, c.minWidth)
	anchor.UpdateMinWidth = updater.SetMinWidth
	anchor.UpdateWidth = updater.SetWidth
end

ns.core.anchors.primary = anchor

AelUIPrimaryAnchor.GetMinimumWidth = function(self)
	return ns.core.db.anchors.primary.minWidth
end

AelUIPrimaryAnchor.SetMinimumWidth = function(self, width)
	ns.core.db.anchors.primary.minWidth = width
	anchor.UpdateMinWidth(width)
end

AelUIPrimaryAnchor.GetOffset = function(self)
	return ns.core.db.anchors.primary.offset
end

AelUIPrimaryAnchor.SetOffset = function(self, position)
	ns.core.db.anchors.primary.offset = position
	anchor:SetPoint('TOP', UIParent, 'CENTER', 0, -position)
end
