local addon = select(2, ...)

local check = AelTodo.checkers

table.insert(addon.sections, {
	name = 'Achievements',
	entries = {
		{
			name = 'Sabertron Assemble (Copper)',
			isAvailable = check.WorldQuestActive(51974),
			isCompleted = check.AchievementCompleted(13054),
		},
		{
			name = 'Giving Even More Back to Nature (Scalebelly Mackerel weekly)',
			isAvailable = check.AchievementCompleted(16552, false),
			isCompleted = check.QuestCompleted(72828),
		},
		{
			name = 'Giving Even More Back to Nature (Thousandbite Piranha weekly)',
			isAvailable = check.AchievementCompleted(16552, false),
			isCompleted = check.QuestCompleted(72827),
		},
		{
			name = 'Giving Even More Back to Nature (Aileron Seamoth weekly)',
			isAvailable = check.AchievementCompleted(16552, false),
			isCompleted = check.QuestCompleted(72826),
		},
		{
			name = 'Giving Even More Back to Nature (Cerulean Spinefish)',
			isAvailable = check.AchievementCompleted(16552, false),
			isCompleted = check.QuestCompleted(72825),
		},
		{
			name = 'Giving Even More Back to Nature (Temporal Dragonhead weekly)',
			isAvailable = check.AchievementCompleted(16552, false),
			isCompleted = check.QuestCompleted(72824),
		},
		{
			name = 'Giving Even More Back to Nature (Islefin Dorado weekly)',
			isAvailable = check.AchievementCompleted(16552, false),
			isCompleted = check.QuestCompleted(72823),
		},
		{
			name = 'Giving Even More Back to Nature (Flying Fish)',
			isCompleted = check.QuestCompleted(70438),
		},
		{
			name = 'Friends in Feathers (do in raid group)',
			isAvailable = check.WorldQuestActive(78370),
			isCompleted = check.AchievementCompleted(19293),
		},
		{
			name = 'Just One More Thing - Lost Atheneum',
			isAvailable = check.WorldQuestActive(77424),
			isCompleted = check.Multiple('ALL', {
				check.QuestCompleted(79601),
				check.QuestCompleted(79600),
				check.QuestCompleted(79599),
			}),
		},
		{
			name = 'Just One More Thing - The Riverbed',
			isAvailable = check.WorldQuestActive(76587),
			isCompleted = check.Multiple('ALL', {
				check.QuestCompleted(79596),
				check.QuestCompleted(79597),
				check.QuestCompleted(79598),
			}),
		},
		{
			name = 'Just One More Thing - Igira\'s Watch',
			isAvailable = check.WorldQuestActive(76734),
			isCompleted = check.Multiple('ALL', {
				check.QuestCompleted(79604),
				check.QuestCompleted(79603),
				check.QuestCompleted(79602),
			}),
		},
		{
			name = 'Just One More Thing - Gaze of Neltharion',
			isAvailable = check.WorldQuestActive(76739),
			isCompleted = check.Multiple('ALL', {
				check.QuestCompleted(79607),
				check.QuestCompleted(79606),
				check.QuestCompleted(79605),
			}),
		},
		{
			name = 'Just One More Thing - Concord Observatory',
			isAvailable = check.WorldQuestActive(76911),
			isCompleted = check.Multiple('ALL', {
				check.QuestCompleted(79610),
				check.QuestCompleted(79609),
				check.QuestCompleted(79608),
			}),
		},
		{
			name = 'Just One More Thing - Winglord\'s Perch',
			isAvailable = check.WorldQuestActive(77362),
			isCompleted = check.Multiple('ALL', {
				check.QuestCompleted(79613),
				check.QuestCompleted(79612),
				check.QuestCompleted(79611),
			}),
		},
		{
			name = 'Clued In',
			isAvailable = check.Multiple('ANY', {
				check.WorldQuestActive(76587), -- Research: Centaur of Ohn'ahran Plains
				check.WorldQuestActive(76734), -- Research: Djaradin of Zaralek Cavern
				check.WorldQuestActive(77424), -- Research: Dracthyr of Forbidden Reach
				check.WorldQuestActive(77362), -- Research: Drakonid of Forbidden Reach
				check.WorldQuestActive(76911), -- Research: Drakonid of Waking Shores
				check.WorldQuestActive(76739), -- Research: Niffen of Zaralek Cavern
			}),
			isCompleted = check.AchievementCompleted(19787),
		},
		{
			name = 'Goggle Wobble',
			isAvailable = check.Multiple('ALL', {
				check.AchievementCompleted(19791, false),
				check.WorldQuestActive(78616),
			}),
		},
		{
			name = 'All Sides of the Story - Tarjin the Blind',
			isCompleted = check.Multiple('ANY', {
				check.AchievementCompleted(16406),
				check.QuestCompleted(70779),
			}),
		},
	},
})
