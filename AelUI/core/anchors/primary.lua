local addon = select(2, ...)

local c = addon.core.config.anchors.primary
local anchorOffset = 180

local primaryAnchor = CreateFrame('Frame', 'AelUIPrimaryAnchor', UIParent)
primaryAnchor:SetPoint('TOP', UIParent, 'CENTER', 0, -anchorOffset)
primaryAnchor:SetSize(c.minWidth, c.height)
primaryAnchor.UpdateWidth = addon.core.anchors.createUpdater(primaryAnchor, c.minWidth)
addon.core.anchors.primary = primaryAnchor

-- deprecated
AelUIAnchor = AelUIPrimaryAnchor
