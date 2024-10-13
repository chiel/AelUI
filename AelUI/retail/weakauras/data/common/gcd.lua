local _, ns = ...

local m = ns.media

table.insert(ns.weakauras.data.common, function(idPrefix)
	local bar = LibWA.CreateBar(idPrefix .. ' - GCD')
	bar.display:SetTexture(m.statusbars.default.name)
	bar.display:SetBackgroundColor({ 50 / 255, 50 / 255, 50 / 255, 1 })
	bar.display:SetBarColor({ 1, 1, 1, 1 })
	bar.display:SetSize(200, 4)
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

	bar.triggers:SetDisjunctive('custom', 'function(t) return t[1] and not t[2] end')
	bar.triggers:AddSpellGlobalCooldown()
	bar.triggers:AddUnitCast('player')

	return bar
end)
