local _, ns = ...

local m = ns.media

ns.weakauras.addProgressText = function(icon)
	icon.display:AddText('%p', {
		font = m.fonts.bold.name,
		size = 14,
		justify = 'CENTER',
		anchor = {
			from = 'BOTTOM',
			to = 'BOTTOM',
			y = -1,
		},
		format = {
			dynamic_threshold = 0,
		},
	})
end
