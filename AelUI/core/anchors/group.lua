local ns = select(2, ...)

local groupAnchor = CreateFrame('Frame', 'AelUIGroupAnchor', UIParent)
groupAnchor:SetPoint('TOP', ns.core.anchors.primary, 'BOTTOM', 0, -100)
groupAnchor:SetSize((100 * 5) + (4 * 4), 70)
ns.core.anchors.group = groupAnchor
