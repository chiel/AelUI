local _, ns = ...

local anchors = ns.anchors
local wa = ns.weakauras

local pc = wa.config.primary.childConfig
local primary = wa.createGrower(pc.width, pc.height, 2, function(width)
	anchors.primary:UpdateWidth(width)
end)

local sc = wa.config.secondary.childConfig
local secondary = wa.createGrower(sc.width, sc.height, 2, function(width)
	anchors.secondary:UpdateWidth(width)
end)

AelUI.weakauras.growers = {
	primary = primary,
	secondary = secondary,
}
