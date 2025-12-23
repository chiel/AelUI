local _, ns = ...

local anchors = ns.anchors
local wa = ns.weakauras

AelUI.weakauras.growers = {}
local growers = { 'primary' }

for _, name in ipairs(growers) do
	local gc = wa.config[name].groupConfig
	local cc = wa.config[name].childConfig

	AelUI.weakauras.growers[name] = wa.createGrower(cc.width, cc.height, gc.spacing, function(width)
		anchors[name]:UpdateWidth(width)
	end)
end
