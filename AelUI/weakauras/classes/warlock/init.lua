local addon = select(2, ...)

addon.weakauras.classes.warlock = {
	name = 'Warlock',
	icon = 626007,

	specs = {
		{
			name = 'Demonology',
			icon = 136172,
			specId = 266,

			spells = {
				{
					name = 'Primary',
					type = 'primary',

					icons = {
						{
							name = 'Summon Demonic Tyrant',
							spellId = 265187,
						},
						{
							name = 'Grimoire: Felguard',
							spellId = 111898,
						},
						{
							name = 'Demonic Strength',
							spellId = 267171,
						},
						{
							name = 'Guillotine',
							spellId = 386833,
						},
						{
							name = 'Call Dreadstalkers',
							spellId = 104316,
						},
						{
							name = 'Demonbolt',
							spellId = 264178,
							glow = {
								type = 'buff',
								auraIds = { 264173 },
							},
							customConfig = function(aura)
								aura.subRegions[4].text_text = '%2.s'
								return aura
							end,
						},
						{
							name = 'Summon Soulkeeper',
							spellId = 386256,
						},
						{
							name = 'Power Siphon',
							spellId = 264130,
						},
					},
				},
				{
					name = 'Secondary',
					type = 'secondary',

					icons = {
						{
							name = 'Command Demon',
							spellId = 119898,
						},
						{
							name = 'Mortal Coil',
							spellId = 6789,
						},
						{
							name = 'Shadowfury',
							spellId = 30283,
						},
						{
							name = 'Fel Domination',
							spellId = 333889,
						},
						{
							name = 'Soulburn',
							spellId = 385900,
						},
						{
							name = 'Demonic Circle',
							spellId = 48018,
						},
						{
							name = 'Demonic Circle: Teleport',
							spellId = 48020,
						},
						{
							name = 'Demonic Gateway',
							spellId = 111771,
						},
					},
				},
				{
					name = 'Defensives',
					type = 'defensives',

					icons = {
						{
							name = 'Dark Pact',
							spellId = 108416,
						},
						{
							name = 'Unending Resolve',
							spellId = 104773,
						},
					},
				},
			},
		},
	},
}
