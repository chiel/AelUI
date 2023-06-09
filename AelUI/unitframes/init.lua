local addon = select(2, ...)

addon.unitframes = {}

addon.unitframes.config = {
	player = {
		indicators = {
			leader = true,
			raidmarker = true,
		},
		texts = {
			health = true,
			healthpercent = true,
			name = true,
		},
	},
}
