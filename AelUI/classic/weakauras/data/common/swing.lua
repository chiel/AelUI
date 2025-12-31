local _, ns = ...

local m = ns.media

table.insert(ns.weakauras.data.common, function(idSuffix)
	local bar = LibWA.CreateBar('Swing' .. idSuffix)

	bar.display:SetTexture(m.statusbars.default.name)
	bar.display:SetBackgroundColor({ 50 / 255, 50 / 255, 50 / 255, 1 })
	bar.display:SetBarColor({ 170 / 255, 170 / 255, 170 / 255, 1 })
	bar.display:SetSize(300, 6)
	bar.display:SetAnchor({
		type = 'SELECTFRAME',
		frame = 'AelUISecondaryAnchor',
		from = 'TOP',
		to = 'BOTTOM',
		y = -2,
	})
	bar.display:AddBorder({
		color = { 0, 0, 0, 1 },
		edge = m.borders.default.name,
		offset = 0,
		size = 1,
	})

	bar.triggers:AddUnitSwingTimer('ranged')

	return bar
end)
