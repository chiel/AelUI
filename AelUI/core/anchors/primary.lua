local ns = select(2, ...)

local onResizeCallbacks = {}

local anchor = CreateFrame('Frame', 'AelUIPrimaryAnchor', UIParent)
anchor.Initialise = function()
	local c = ns.db.anchors.primary
	anchor:SetPoint('TOP', UIParent, 'CENTER', 0, -c.offset)
	anchor:SetSize(c.minWidth, ns.db.icons.primary.size)

	local updater = ns.anchors.createUpdater(anchor, c.minWidth)
	anchor.GetCurrentWidth = updater.GetWidth
	anchor.UpdateMinWidth = updater.SetMinWidth
	anchor.UpdateWidth = updater.SetWidth

	updater.OnResize(function(newWidth)
		onResizeFired = true
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

anchor.GetMinimumWidth = function(self)
	return ns.db.anchors.primary.minWidth
end

anchor.SetMinimumWidth = function(self, width)
	ns.db.anchors.primary.minWidth = width
	anchor.UpdateMinWidth(width)
end

anchor.GetOffset = function(self)
	return ns.db.anchors.primary.offset
end

anchor.SetOffset = function(self, position)
	ns.db.anchors.primary.offset = position
	anchor:SetPoint('TOP', UIParent, 'CENTER', 0, -position)
end

ns.anchors.primary = anchor
