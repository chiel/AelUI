local _, ns = ...

local AelTrackers = LibStub('AelTrackers-1.0')

local m = ns.media

AelTrackers.setDefaults({
	text = {
		font = {
			file = m.fonts.bold.file,
			flags = 'OUTLINE',
			size = 18,
		},
		formatters = {
			duration = ns.formatters.duration,
		},
	},
})
