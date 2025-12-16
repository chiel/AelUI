local _, ns = ...

local wa = ns.weakauras

wa.helpers.icon = function(id, config)
	local c = config or {}

	local icon = LibWA.CreateIcon(id)
	icon.display:SetSize(c.width or 40, c.height or 40)

	return icon
end
