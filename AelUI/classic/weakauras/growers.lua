local _, ns = ...

local anchors = ns.anchors
local wa = ns.weakauras

AelUI.weakauras.growers = {}
local growers = { 'primary' }

for _, name in ipairs(growers) do
	local cc = wa.config[name].childConfig

	AelUI.weakauras.growers[name] = wa.createGrower(cc.width, cc.height, 2, function(width)
		anchors[name]:UpdateWidth(width)
	end)
end
