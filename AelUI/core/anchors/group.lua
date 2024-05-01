local ns = select(2, ...)

local groupAnchor = CreateFrame('Frame', 'AelUIGroupAnchor', UIParent)
groupAnchor:SetPoint('TOP', ns.anchors.primary, 'BOTTOM', 0, -100)
groupAnchor:SetSize((100 * 5) + (4 * 4), 70)
ns.anchors.group = groupAnchor
