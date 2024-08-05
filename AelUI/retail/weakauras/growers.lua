local _, ns = ...

local wa = ns.weakauras

local pc = wa.config.primary.childConfig
local primary = wa.createGrower(pc.width, pc.height, 2, function(width)
	print('primary width changed', width)
end)

local sc = wa.config.secondary.childConfig
local secondary = wa.createGrower(sc.width, sc.height, 2, function(width)
	print('secondary width changed', width)
end)

AelUI.weakauras.growers = {
	primary = primary,
	secondary = secondary,
}
