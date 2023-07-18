local addon = select(2, ...)

addon.weakauras.classes.evoker = {
	name = 'Evoker',
	icon = 4574311,

	specs = {
		{
			name = 'Devastation',
			icon = 4511811,
			specId = 1467,

			spells = {
				{
					name = 'Primary',
					type = 'primary',

					icons = {
						{
							name = 'Dragonrage',
							spellId = 375087,
						},
						{
							name = 'Deep Breath',
							spellId = 357210,
						},
						{
							name = 'Tip the Scales',
							spellId = 370553,
						},
						{
							name = 'Fire Breath',
							spellId = 357208,
						},
						{
							name = 'Eternity Surge',
							spellId = 359073,
						},
						{
							name = 'Shattering Star',
							spellId = 370452,
						},

						{
							name = 'Azure Strike', -- hide?
							spellId = 362969,
						},
						{
							name = 'Disintegrate', -- hide?
							spellId = 356995,
						},
						{
							name = 'Living Flame', -- hide?
							spellId = 361469,
						},
						{
							name = 'Pyre', -- hide?
							spellId = 357211,
						},
					},
				},
				{
					name = 'Secondary',
					type = 'secondary',

					icons = {
						{
							name = 'Quell',
							spellId = 351338,
						},
						{
							name = 'Tail Swipe',
							spellId = 368970,
						},
						{
							name = 'Wing Buffer',
							spellId = 357214,
						},
						{
							name = 'Landslide',
							spellId = 358385,
						},
						{
							name = 'Emerald Blossom',
							spellId = 355913,
						},
						{
							name = 'Verdant Embrace',
							spellId = 360995,
						},
						{
							name = 'Expunge',
							spellId = 365585,
						},
						{
							name = 'Cauterizing Flame',
							spellId = 374251,
						},
						{
							name = 'Hover',
							spellId = 358267,
						},
					},
				},
				{
					name = 'Defensives',
					type = 'defensives',

					icons = {
						{
							name = 'Zephyr',
							spellId = 374227,
						},
						{
							name = 'Renewing Blaze',
							spellId = 374348,
						},
						{
							name = 'Obsidian Scales',
							spellId = 363916,
						},
					},
				},
			},
		},
	},
}
