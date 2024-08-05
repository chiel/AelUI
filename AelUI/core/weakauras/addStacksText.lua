local _, ns = ...

local m = ns.media

ns.weakauras.addStacksText = function(icon)
	icon.display:AddText('%s', {
		font = m.fonts.bold.name,
		size = 12,
		justify = 'RIGHT',
		anchor = {
			from = 'TOPRIGHT',
			to = 'TOPRIGHT',
			y = -1,
		},
	})
end
