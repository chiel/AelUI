local _, ns = ...

local primary = ns.anchors.create('AelUIPrimaryAnchor')
primary:SetPoint('TOP', AelUIParent, 'CENTER', 0, -280)
primary:SetMinWidth(358)
primary:SetHeight(58)

ns.anchors.primary = primary
