local addon = select(2, ...)

local check = AelTodo.checkers

table.insert(addon.sections, {
	name = 'Dragon Quests',
	entries = {
		{
			name = 'A Blue Dawn',
			isCompleted = check.AchievementCompleted(17773),
		},
		{
			name = 'Active Listening Skills',
			isCompleted = check.AchievementCompleted(17734),
		},
		{
			name = 'Of the Tyr\'s Guard',
			isCompleted = check.AchievementCompleted(18958),
		},
		{
			name = 'A New Beginning',
			isCompleted = check.AchievementCompleted(17546),
		},
		{
			name = 'In Tyr\'s Footsteps',
			isCompleted = check.AchievementCompleted(16683),
		},
		{
			name = 'Fringe Benefits',
			isCompleted = check.Multiple('ANY', {
				check.AchievementCompleted(19507),
				check.QuestsCompleted(1, {
					75466, -- Lost Time-Lost Vikings
					75657, -- Time-Lost Trio
					76076, -- Small Things
					76162, -- Missing Mojo
					76244, -- Prince in Peril
					75970, -- Tracked Through Time
					75971, -- Squeaky Toy of Time and Space
					75988, -- Lucky Hearthstone Card
					75991, -- What Could Have Been
					76251, -- Fowl Beasts
					76246, -- Manastorm Mystique
					76266, -- A Multitude of Tasks
					76269, -- A Mislaid Egg
					75987, -- Woolomancer
					75989, -- The Black Prince Parade
					75990, -- Star-Crossed Lovers
				}),
			}),
		},
	},
})
