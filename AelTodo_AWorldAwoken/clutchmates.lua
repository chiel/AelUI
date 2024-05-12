local addon = select(2, ...)

local check = AelTodo.checkers

table.insert(addon.sections, {
	name = 'Oh My God, They Were Clutchmates',
	entries = {
		{
			name = 'Legend of the Multiverse',
			isAvailable = check.AchievementCompleted(18615, false),
			isCompleted = check.QuestCompleted(77236), -- When Time Needs Mending (weekly)
		},
	},
})
