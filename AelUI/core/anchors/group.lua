local addon = select(2, ...)

local offsetX = -((40 * 8) + 20 + 4)
local offsetY = 40 * (5 + 2 + (1.5 * 4))

local groupAnchor = CreateFrame('Frame', 'AelUIGroupAnchor', UIParent)
groupAnchor:SetPoint('TOPRIGHT', addon.core.anchors.primary, 'TOPLEFT', offsetX, offsetY)
groupAnchor:SetSize(1, 1)
addon.core.anchors.group = groupAnchor
