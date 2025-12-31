local _, ns = ...

local wa = ns.weakauras
local m = ns.media

wa.helpers.addStacksText = function(icon)
	icon.display:AddText('%s', {
		font = m.fonts.bold.name,
		size = 12,
		justify = 'RIGHT',
		anchor = {
			from = 'TOPRIGHT',
			to = 'TOPRIGHT',
			x = -1,
			y = -1,
		},
	})
end
