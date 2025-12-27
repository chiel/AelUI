local _, ns = ...

local pc = ns.config.groups.primary
local sc = ns.config.groups.secondary

local primary = ns.anchors.create('AelUIPrimaryAnchor')
primary:SetPoint('TOP', AelUIParent, 'CENTER', 0, -240)
primary:SetMinWidth((pc.minIcons * pc.width) + ((pc.minIcons - 1) * pc.spacing))
primary:SetHeight(pc.height)

local secondary = ns.anchors.create('AelUISecondaryAnchor')
secondary:SetPoint('TOP', primary, 'BOTTOM', 0, -sc.spacing)
secondary:SetMinWidth((sc.minIcons * sc.width) + ((sc.minIcons - 1) * sc.spacing))
secondary:SetHeight(sc.height)

ns.anchors.primary = primary
ns.anchors.secondary = secondary
