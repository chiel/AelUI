local addon = select(2, ...)

addon.weakauras.classes.deathknight = {
	name = 'Death Knight',
	icon = 0,

	specs = {
		{
			name = 'Frost',
			icon = 0,
			specId = 251,

			spells = {
				{
					name = 'Primary',
					type = 'primary',

					icons = {
						{
							name = 'Frostwyrm\'s Fury',
							spellId = 279302,
						},
						{
							name = 'Abomination Limb',
							spellId = 383269,
						},
						{
							name = 'Empower Rune Weapon',
							spellId = 47568,
						},
						{
							name = 'Pillar of Frost',
							spellId = 51271,
							buffId = 51271,
						},
						{
							name = 'Remorseless Winter',
							spellId = 196770,
						},
						{
							name = 'Death and Decay',
							spellId = 43265,
						},
						{
							name = 'Obliterate',
							spellId = 49020,
							glow = {
								type = 'overlay',
							},
						},
						{
							name = 'Howling Blast',
							spellId = 49184,
							glow = {
								type = 'overlay',
							},
						},
					},
				},
				{
					name = 'Secondary',
					type = 'secondary',

					icons = {
						{
							name = 'Mind Freeze',
							spellId = 47528,
						},
						{
							name = 'Death Grip',
							spellId = 49576,
						},
						{
							name = 'Blinding Sleet',
							spellId = 207167,
						},
						{
							name = 'Chains of Ice',
							spellId = 45524,
						},
						{
							name = 'Death\'s Advance',
							spellId = 48265,
						},
						{
							name = 'Raise Dead',
							spellId = 46585,
						},
						{
							name = 'Dark Command',
							spellId = 56222,
						},
					},
				},
				{
					name = 'Defensives',
					type = 'defensives',

					icons = {
						{
							name = 'Anti-Magic Shell',
							spellId = 48707,
						},
						{
							name = 'Anti-Magic Zone',
							spellId = 51052,
						},
						{
							name = 'Icebound Fortitude',
							spellId = 48792,
						},
						{
							name = 'Lichborne',
							spellId = 49039,
						},
					},
				},
			},
		},
	},
}
