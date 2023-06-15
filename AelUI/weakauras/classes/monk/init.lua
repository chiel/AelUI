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

			groups = {
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
							name = 'Bonedust Brew',
							spellId = 386276,
						},
						{
							name = 'Touch of Death',
							spellId = 322109,
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
	},
}
