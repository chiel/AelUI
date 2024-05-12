local addon = select(2, ...)

local check = AelTodo.checkers

table.insert(addon.sections, {
	name = 'Weeklies',
	entries = {
		{
			name = 'Blooming Dreamseeds',
			isCompleted = check.QuestCompleted(78821),
		},
		{
			name = 'Community Feast',
			isCompleted = check.QuestCompleted(70893),
		},
		{
			name = 'Dragonbane Keep',
			isCompleted = check.QuestCompleted(70866),
		},
		{
			name = 'Dreamsurge',
			isCompleted = check.QuestCompleted(77251),
		},
		{
			name = 'Grand Hunt',
			isCompleted = check.Multiple('ALL', {
				check.QuestCompleted(70906),
				check.QuestCompleted(71136),
				check.QuestCompleted(71137),
			}),
		},
		{
			name = 'Last Hurrah',
			isCompleted = check.QuestCompleted(80389),
			-- 79073 - hidden quest completed on hand in
			-- 80385 - Last Hurrah: Dragon Isles
			-- 80386 - Last Hurrah: Zaralek Caverns and Time Rifts
			-- 80388 - Last Hurrah: Emerald Dream
			-- 80389 - Last Hurrah
		},
		{
			name = 'Researchers Under Fire',
			isCompleted = function()
				return false
			end,
		},
		{
			name = 'Superbloom',
			isCompleted = check.QuestCompleted(78319),
		},
		{
			name = 'The Big Dig',
			isCompleted = function()
				return false
			end,
		},
		{
			name = 'Time Rift',
			isCompleted = check.QuestCompleted(77236),
		},

		{
			name = 'Dream Seeds rep',
			isCompleted = check.Multiple('ALL', {
				check.QuestCompleted(77217), -- TBC
				-- check.QuestCompleted(77498), -- TBC
				-- check.QuestCompleted(78975), -- TBC
				-- check.QuestCompleted(77389), -- TBC
				--
				-- on plant - 78818, 77541
				-- on open  - none
				--
				-- ringing rose, blue quality
				-- 77386 - add extra seed to existing seed
				-- 78790 - add dewdrops to seed
				--
				-- whisperbloom sapling, blue quality
				-- add seed to existing seed: 77491, 77542
				-- add dewdrops to seed: 78817
				-- on bloom: -
				-- on loot: -
			}),
		},
	},
})

-- 75525 - secured shipment (weekly)
