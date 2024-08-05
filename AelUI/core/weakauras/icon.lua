local _, ns = ...

local m = ns.media

ns.weakauras.icon = function(id, config)
	local c = config or {}

	local icon = LibWA.CreateIcon(id)
	icon.display:SetSize(c.width or 40, c.height or 40)
	icon.display:SetCooldown({ inverse = true })
	icon.display:SetKeepAspectRatio(true)

	icon.display:AddBorder({
		color = { 0, 0, 0, 1 },
		edge = m.borders.default.name,
		offset = 0,
		size = 1,
	})

	return icon
end
