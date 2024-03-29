local addon = select(2, ...)

-- Celestial Brew - 322507
-- Purifying Brew - 119582
-- Rushing Jade Wind - 116847

addon.weakauras.classes.monk = {
	name = 'Monk',
	icon = 626002,

	specs = {
		{
			name = 'Brewmaster',
			icon = 608951,
			specId = 268,

			spells = {
				{
					name = 'Primary',
					type = 'primary',

					icons = {
						{
							name = 'Invoke Niuzao, the Black Ox',
							spellId = 132578,
						},
						{
							name = 'Weapons of Order',
							spellId = 387184,
						},
						{
							name = 'Exploding Keg',
							spellId = 325153,
						},
						{
							name = 'Summon White Tiger Statue',
							spellId = 388686,
						},
						{
							name = 'Bonedust Brew',
							spellId = 386276,
						},
						{
							name = 'Touch of Death',
							spellId = 322109,
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
							name = 'Blackout Kick',
							spellId = 205523,
						},
						{
							name = 'Breath of Fire',
							spellId = 115181,
						},
						{
							name = 'Keg Smash',
							spellId = 121253,
						},
						{
							name = 'Rising Sun Kick',
							spellId = 107428,
						},
						{
							name = 'Chi Wave',
							spellId = 115098,
						},
						{
							name = 'Expel Harm',
							spellId = 322101,
						},
					},
				},
				{
					name = 'Secondary',
					type = 'secondary',

					icons = {
						{
							name = 'Provoke',
							spellId = 115546,
						},
						{
							name = 'Spear Hand Strike',
							spellId = 116705,
						},
						{
							name = 'Leg Sweep',
							spellId = 119381,
						},
						{
							name = 'Paralysis',
							spellId = 115078,
						},
						{
							name = 'Ring of Peace',
							spellId = 116844,
						},
						{
							name = 'Roll',
							spellId = 109132,
						},
						{
							name = 'Detox',
							spellId = 218164,
						},
						{
							name = 'Tiger\'s Lust',
							spellId = 116841,
						},
						{
							name = 'Transcendence',
							spellId = 101643,
						},
						{
							name = 'Transcendence: Transfer',
							spellId = 119996,
						},
					},
				},
				{
					name = 'Defensives',
					type = 'defensives',

					icons = {
						{
							name = 'Dampen Harm',
							spellId = 122278,
						},
						{
							name = 'Diffuse Magic',
							spellId = 122783,
						},
						{
							name = 'Fortifying Brew',
							spellId = 115203,
						},
						{
							name = 'Zen Meditation',
							spellId = 115176,
						},
					},
				},
			},
		},
		{
			name = 'Mistweaver',
			icon = 608952,
			specId = 270,

			auraBars = {
				{
					name = 'Ancient Teachings',
					auraId = 388026,
					color = { 175, 175, 175 },
				},
			},

			spells = {
				{
					name = 'Primary',
					type = 'primary',

					icons = {
						{
							name = 'Invoke Chi-Ji, the Red Crane',
							spellId = 325197,
						},
						{
							name = 'Invoke Yu\'lon, the Jade Serpent',
							spellId = 322118,
						},
						{
							name = 'Life Cocoon',
							spellId = 116849,
						},
						{
							name = 'Revival',
							spellId = 115310,
						},
						{
							name = 'Zen Pulse',
							spellId = 124081,
						},
						{
							name = 'Faeline Stomp',
							spellId = 388193,
						},
						{
							name = 'Thunder Focus Tea',
							spellId = 116680,
						},
						{
							name = 'Renewing Mist',
							spellId = 115151,
						},
						{
							name = 'Rising Sun Kick',
							spellId = 107428,
						},
						{
							name = 'Blackout Kick',
							spellId = 100784,
						},
						{
							name = 'Expel Harm',
							spellId = 322101,
						},
						{
							name = 'Sheilun\'s Gift',
							spellId = 399491,
						},
						{
							name = 'Enveloping Mist',
							spellId = 124682,
						},
						{
							name = 'Essence Font',
							spellId = 191837,
						},
					},
				},
				{
					name = 'Secondary',
					type = 'secondary',

					icons = {
						{
							name = 'Spear Hand Strike',
							spellId = 116705,
						},
						{
							name = 'Leg Sweep',
							spellId = 119381,
						},
						{
							name = 'Paralysis',
							spellId = 115078,
						},
						{
							name = 'Ring of Peace',
							spellId = 116844,
						},
						{
							name = 'Chi Burst',
							spellId = 123986,
						},
						{
							name = 'Touch of Death',
							spellId = 322109,
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
							name = 'Roll',
							spellId = 109132,
						},
						{
							name = 'Detox',
							spellId = 218164,
						},
						{
							name = 'Tiger\'s Lust',
							spellId = 116841,
						},
						{
							name = 'Transcendence',
							spellId = 101643,
						},
						{
							name = 'Transcendence: Transfer',
							spellId = 119996,
						},
					},
				},
				{
					name = 'Defensives',
					type = 'defensives',

					icons = {
						{
							name = 'Dampen Harm',
							spellId = 122278,
						},
						{
							name = 'Diffuse Magic',
							spellId = 122783,
						},
						{
							name = 'Fortifying Brew',
							spellId = 115203,
						},
					},
				},
			},
		},
	},
}
