local ns = select(2, ...)

local anchor = CreateFrame('Frame', 'AelUISecondaryAnchor', UIParent)
anchor.Initialise = function()
	local db = ns.db
	local c = db.anchors.secondary
	anchor:SetPoint('TOP', ns.anchors.primary, 'BOTTOM', 0, -db.spacing)
	anchor:SetSize(c.minWidth, db.icons.secondary.size)

	local updater = ns.anchors.createUpdater(anchor, c.minWidth)
	anchor.UpdateWidth = updater.SetWidth
end

ns.anchors.secondary = anchor
