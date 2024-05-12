local addon = select(2, ...)

local check = AelTodo.checkers

table.insert(addon.sections, {
	name = 'Mounts',
	entries = {
		{
			name = 'Big Slick in the City - Briggul daily',
			isAvailable = check.MountKnown(1729, false),
			isCompleted = check.Multiple('ANY', {
				check.QuestCompleted(74514), -- The Slowest Fan Club
				check.QuestCompleted(74515), -- Snail Mail
				check.QuestCompleted(74516), -- A Snail's Pace
				check.QuestCompleted(74517), -- All Terrain Snail
				check.QuestCompleted(74518), -- Resistance Training
				check.QuestCompleted(74519), -- Good for Goo
				check.QuestCompleted(74520), -- Less Cargo
			}),
		},
	},
})
