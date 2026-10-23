local _, ns = ...

local config = {
	primary = {
		width = 58,
		height = 58,
		spacing = 2,
		minIcons = 6,
	},
	secondary = {
		width = 42,
		height = 42,
		spacing = 2,
		minIcons = 7,
	},
}

local pc = config.primary
local sc = config.secondary

local primary = ns.anchors.create('AelUIPrimaryAnchor')
primary:SetPoint('TOP', AelUIParent, 'CENTER', 0, -360)
primary:SetMinWidth((pc.minIcons * pc.width) + ((pc.minIcons - 1) * pc.spacing))
primary:SetHeight(pc.height)

local secondary = ns.anchors.create('AelUISecondaryAnchor')
secondary:SetPoint('TOP', primary, 'BOTTOM', 0, -sc.spacing)
secondary:SetMinWidth((sc.minIcons * sc.width) + ((sc.minIcons - 1) * sc.spacing))
secondary:SetHeight(sc.height)

ns.anchors.primary = primary
ns.anchors.secondary = secondary
