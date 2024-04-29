local addon = select(2, ...)

addon.classic.weakauras.classes.warlock = {
	name = 'Warlock',
	icon = 626007,
	class = 'WARLOCK',

	groups = {
		tracking = {
			{ -- Haunt
				debuffId = 403501,
				custom = function(icon)
					icon.load:SpellKnown(403501)
				end,
			},
			{ debuffId = 1014 }, -- Curse of Agony
			{ debuffId = 6222 }, -- Corruption
			{ debuffId = 403677 }, -- Drain Life
		},
	},
}
