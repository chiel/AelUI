local addon = select(2, ...)

local c = addon.core.config.anchors.secondary
local spacing = addon.core.config.icons.spacing

local secondaryAnchor = CreateFrame('Frame', 'AelUISecondaryAnchor', UIParent)
secondaryAnchor:SetPoint('TOP', addon.core.anchors.primary, 'BOTTOM', 0, -spacing)
secondaryAnchor:SetSize(c.minWidth, c.height)
secondaryAnchor.UpdateWidth = addon.core.anchors.createUpdater(secondaryAnchor, c.minWidth)
addon.core.anchors.secondary = secondaryAnchor
