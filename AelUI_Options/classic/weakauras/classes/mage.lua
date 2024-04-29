local addon = select(2, ...)

addon.classic.weakauras.classes.mage = {
	name = 'Mage',
	icon = 626001,
	class = 'MAGE',

	groups = {
		primary = {
			{ spellId = 5019 }, -- Shoot
			{ spellId = 401556 }, -- Living Flame
			{ spellId = 122 }, -- Frost Nova
		},
	},
}
