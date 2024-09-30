local _, ns = ...

local primary = ns.anchors.create('AelUIPrimaryAnchor')
primary:SetPoint('TOP', UIParent, 'CENTER', 0, -240)
primary:SetMinWidth((7 * 40) + (6 * 2))
primary:SetHeight(40)

local secondary = ns.anchors.create('AelUISecondaryAnchor')
secondary:SetPoint('TOP', primary, 'BOTTOM', 0, -2)
secondary:SetMinWidth((7 * 34) + (6 * 2))
secondary:SetHeight(34)

ns.anchors.primary = primary
ns.anchors.secondary = secondary
