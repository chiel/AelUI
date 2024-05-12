local addon = select(2, ...)

addon.config.alchemy = {
	{
		name = 'Treatise',
		quests = { 74108 },
		isAvailable = hasSkill(171, 25),
	},
	{
		name = 'Faction Trader Quest',
		quests = { 66937, 66938, 66940, 72427, 75363, 75371 },
		isAvailable = hasSkill(171, 50),
	},
	{
		name = 'Profession Trainer Quest',
		quests = { 70530, 70531, 70532, 70533 },
		isAvailable = hasSkill(171, 50),
	},
	{
		name = 'Decaying Phlegm',
		note = 'Decayed Enemies',
		coords = 'The Azure Span 17.27 36.98',
		quests = { 70504 },
	},
	{
		name = 'Elementious Splinter',
		note = 'Elemental Enemies',
		quests = { 70511 },
	},
	{
		name = 'Experimental Substance',
		note = 'Chests / Scout Packs',
		quests = { 66373 },
	},
	{
		name = 'Reawakened Catalyst',
		note = 'Chests / Scout Packs',
		quests = { 66374 },
	},

	-- one-time
	-- 75646 - Nutrient Diluted Protofluid - Zaralek Cavern (2133) 52.63 18.30
	-- 75649 - Marrow-Ripened Slime - Zaralek Cavern (2133) 62.13 41.13
	-- 75651 - Suspicious Mold - Zaralek Cavern (2133) 40.44 59.21
}
