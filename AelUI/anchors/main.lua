local _, ns = ...

local config = {
	primary = {
		width = 64,
		height = 64,
		spacing = 2,
		minIcons = 6,
	},
	secondary = {
		width = 44,
		height = 44,
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
