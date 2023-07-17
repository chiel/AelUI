local addon = select(2, ...)

addon.weakauras.classes.druid = {
	name = 'Druid',
	icon = 625999,

	specs = {
		{
			name = 'Balance',
			icon = 136096,
			specId = 102,

			spells = {
				{
					name = 'Primary',
					type = 'primary',

					icons = {
						{
							name = 'Celestial Alignment',
							spellId = 102560,
						},
						{
							name = 'Fury of Elune',
							spellId = 202770,
						},
						{
							name = 'Wrath',
							spellId = 190984,
							buffId = 48517,
						},
						{
							name = 'Starfire',
							spellId = 194153,
							buffId = 48518,
						},
						{
							name = 'Starsurge',
							spellId = 78674,
							glow = {
								type = 'overlay',
							},
							customConfig = function(aura)
								aura.desaturate = true
								table.insert(aura.conditions[3].changes, {
									property = 'desaturate',
								})
								return aura
							end,
						},
						{
							name = 'Starfall',
							spellId = 191034,
							glow = {
								type = 'overlay',
							},
							customConfig = function(aura)
								aura.desaturate = true
								table.insert(aura.conditions[3].changes, {
									property = 'desaturate',
								})
								return aura
							end,
						},
					},
				},
				{
					name = 'Secondary',
					type = 'secondary',

					icons = {
						{
							name = 'Dash',
							spellId = 1850,
						},
						{
							name = 'Entangling Roots',
							spellId = 339,
						},
						{
							name = 'Incapacitating Roar',
							spellId = 99,
						},
						{
							name = 'Innervate',
							spellId = 29166,
						},
						{
							name = 'Prowl',
							spellId = 5215,
						},
						{
							name = 'Soothe',
							spellId = 2908,
						},
						{
							name = 'Stampeding Roar',
							spellId = 106898,
						},
						{
							name = 'Typhoon',
							spellId = 132469,
						},
						{
							name = 'Ursol\'s Vortex',
							spellId = 102793,
						},
						{
							name = 'Wild Charge',
							spellId = 102401,
						},
						{
							name = 'Solar Beam',
							spellId = 78675,
						},
					},
				},
				{
					name = 'Defensives',
					type = 'defensives',

					icons = {
						{
							name = 'Frenzied Regeneration',
							spellId = 22842,
						},
						{
							name = 'Nature\'s Vigil',
							spellId = 124974,
						},
						{
							name = 'Renewal',
							spellId = 108238,
						},
						{
							name = 'Barkskin',
							spellId = 22812,
						},
					},
				},
			},
		},
	},
}
