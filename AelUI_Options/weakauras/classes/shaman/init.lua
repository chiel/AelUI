local addon = select(2, ...)

addon.weakauras.classes.shaman = {
	name = 'Shaman',
	icon = 626006,

	specs = {
		{
			name = 'Enhancement',
			icon = 237581,
			specId = 263,

			spells = {
				{
					name = 'Primary',
					type = 'primary',

					icons = {
						{
							name = 'Feral Spirit',
							spellId = 51533,
						},
						{
							name = 'Sundering',
							spellId = 197214,
						},
						{
							name = 'Primordial Wave',
							spellId = 375982,
							buffId = 375986,
							glow = {
								type = 'buff',
								auraIds = { 375986 },
							},
						},
						{
							name = 'Flame Shock',
							spellId = 188389,
						},
						{
							name = 'Lava Burst',
							spellId = 51505,
						},
						{
							name = 'Lava Lash',
							spellId = 60103,
							glow = {
								type = 'buff',
								auraIds = { 215785 },
							},
							customConfig = function(aura)
								aura.triggers[3] = {
									trigger = {
										type = 'aura2',
										unit = 'player',
										debuffType = 'HELPFUL',
										auraspellids = { '390371' },
										useExactSpellId = true,
									},
								}

								aura.subRegions[4].text_text = '%3.s'
								return aura
							end,
						},
						{
							name = 'Stormstrike',
							spellId = 17364,
						},
						{
							name = 'Frost Shock',
							spellId = 196840,
							customConfig = function(aura)
								aura.triggers[2] = {
									trigger = {
										type = 'aura2',
										unit = 'player',
										debuffType = 'HELPFUL',
										auraspellids = { '334196' },
										useExactSpellId = true,
									},
								}

								aura.subRegions[3].text_text = '%2.s'

								return aura
							end,
						},
						{
							name = 'Crash Lightning',
							spellId = 187874,
						},
						{
							name = 'Ice Strike',
							spellId = 342240,
						},
					},
				},
				{
					name = 'Secondary',
					type = 'secondary',

					icons = {
						{
							name = 'Capacitor Totem',
							spellId = 192058,
						},
						{
							name = 'Earthbind Totem',
							spellId = 2484,
						},
						{
							name = 'Hex',
							spellId = 269352,
						},
						{
							name = 'Purge',
							spellId = 370,
						},
						{
							name = 'Spirit Walk',
							spellId = 58875,
						},
						{
							name = 'Thunderstorm',
							spellId = 51490,
						},
						{
							name = 'Wind Rush Totem',
							spellId = 192077,
						},
						{
							name = 'Wind Shear',
							spellId = 57994,
						},
						{
							name = 'Cleanse Spirit',
							spellId = 51886,
						},
						{
							name = 'Poison Cleansing Totem',
							spellId = 383013,
						},
					},
				},
				{
					name = 'Defensives',
					type = 'defensives',

					icons = {
						{
							name = 'Ancestral Guidance',
							spellId = 108281,
						},
						{
							name = 'Earth Elemental',
							spellId = 198103,
						},
						{
							name = 'Astral Shift',
							spellId = 108271,
						},
					},
				},
			},
		},
	},
}
