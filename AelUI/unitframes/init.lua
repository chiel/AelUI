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

	party = {
		bars = {
			power = 'healer',
		},
		indicators = {
			leader = true,
			raidmarker = true,
			readycheck = true,
			resurrect = true,
			role = true,
			summon = true,
		},
		range = true,
		texts = {
			name = true,
			healthpercent = true,
			power = true,
		},
	},
}
