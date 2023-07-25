local addon = select(2, ...)

addon.weakauras.classes.warrior = {
	name = 'Warrior',
	icon = 626008,

	specs = {
		{
			name = 'Protection',
			icon = 134952,
			specId = 73,

			spells = {
				{
					name = 'Primary',
					type = 'primary',

					icons = {
						{
							name = 'Avatar',
							spellId = 107574,
						},
						{
							name = 'Thunderous Roar',
							spellId = 384318,
						},
						{
							name = 'Ravager',
							spellId = 228920,
						},
						{
							name = 'Demoralizing Shout',
							spellId = 1160,
						},
						{
							name = 'Spell Reflection',
							spellId = 23920,
						},
						{
							name = 'Shield Charge',
							spellId = 385952,
						},
						{
							name = 'Shield Slam',
							spellId = 23922,
							glow = {
								type = 'overlay',
							},
						},
						{
							name = 'Revenge',
							spellId = 6572,
							glow = {
								type = 'overlay',
							},
						},
						{
							name = 'Thunder Clap',
							spellId = 6343,
						},
						{
							name = 'Shockwave',
							spellId = 46968,
						},
						{
							name = 'Victory Rush',
							spellId = 34428,
						},
						{
							name = 'Execute',
							spellId = 163201,
						},
					},
				},
				{
					name = 'Secondary',
					type = 'secondary',

					icons = {
						{
							name = 'Arcane Torrent',
							spellId = 129597,
						},
						{
							name = 'Taunt',
							spellId = 355,
						},
						{
							name = 'Challenging Shout',
							spellId = 1161,
						},
						{
							name = 'Intimidating Shout',
							spellId = 5246,
						},
						{
							name = 'Pummel',
							spellId = 6552,
						},
						{
							name = 'Storm Bolt',
							spellId = 107570,
						},
						{
							name = 'Charge',
							spellId = 100,
						},
						{
							name = 'Heroic Leap',
							spellId = 6544,
						},
						{
							name = 'Intervene',
							spellId = 3411,
						},
					},
				},
				{
					name = 'Defensives',
					type = 'defensives',

					icons = {
						{
							name = 'Spell Block',
							spellId = 392966,
						},
						{
							name = 'Rallying Cry',
							spellId = 97462,
						},
						{
							name = 'Shield Wall',
							spellId = 871,
						},
						{
							name = 'Last Stand',
							spellId = 12975,
						},
					},
				},
			},
		},
	},
}
