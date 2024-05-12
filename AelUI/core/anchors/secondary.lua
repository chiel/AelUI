local ns = select(2, ...)

local onResizeCallbacks = {}

local anchor = CreateFrame('Frame', 'AelUISecondaryAnchor', UIParent)
anchor.Initialise = function()
	local db = ns.db
	local c = db.anchors.secondary
	anchor:SetPoint('TOP', ns.anchors.primary, 'BOTTOM', 0, -db.spacing)
	anchor:SetSize(c.minWidth, db.icons.secondary.size)

	local updater = ns.anchors.createUpdater(anchor, c.minWidth)
	anchor.UpdateWidth = updater.SetWidth

	updater.OnResize(function(newWidth)
		for _, callback in ipairs(onResizeCallbacks) do
			callback(newWidth)
		end
	end)

	C_Timer.After(1, function()
		for _, callback in ipairs(onResizeCallbacks) do
			callback(updater.GetWidth())
		end
	end)
end

anchor.OnResize = function(self, callback)
	table.insert(onResizeCallbacks, callback)
end

ns.anchors.secondary = anchor
