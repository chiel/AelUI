local addon = select(2, ...)

addon.config = {}

addon.config.general = {
	{
		name = 'Show Your Mettle',
		quests = { 70221 },
		isAvailable = AelTodo.HasReputation(2544, 2),
	},
}

addon.config.skillLineMap = {
	[171] = 'alchemy',
	[164] = 'blacksmithing',
	[333] = 'enchanting'
	[202] = 'engineering'
	[182] = 'herbalism'
	[773] = 'inscription'
	[755] = 'jewelcrafting'
	[165] = 'leatherworking'
	[186] = 'mining'
	[393] = 'skinning'
	[197] = 'tailoring'
}
