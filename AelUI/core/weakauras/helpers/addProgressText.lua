local _, ns = ...

local wa = ns.weakauras
local m = ns.media

wa.helpers.addProgressText = function(icon)
	icon.display:AddText('%p', {
		font = m.fonts.bold.name,
		size = 16,
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
