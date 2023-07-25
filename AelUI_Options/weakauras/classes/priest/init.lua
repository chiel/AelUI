local addon = select(2, ...)

addon.weakauras.classes.priest = {
	name = 'Priest',
	icon = 626004,

	specs = {
		{
			name = 'Shadow',
			icon = 136207,
			specId = 258,

			spells = {
				{
					name = 'Primary',
					type = 'primary',

					icons = {
						{
							name = 'Shadowfiend',
							spellId = 34433,
						},
						{
							name = 'Power Infusion',
							spellId = 10060,
						},
						{
							name = 'Mind Games',
							spellId = 375901,
						},
						{
							name = 'Void Torrent',
							spellId = 263165,
						},
						{
							name = 'Void Eruption',
							spellId = 228260,
							customConfig = function(aura)
								aura.triggers[2] = {
									trigger = {
										type = 'aura2',
										unit = 'player',
										debuffType = 'HELPFUL',
										auraspellids = { '194249' }, -- void form
										useExactSpellId = true,
										matchesShowOn = 'showOnMissing',
									},
								}

								aura.triggers.disjunctive = 'custom'
								aura.triggers.customTriggerLogic = 'function(t) return t[2] end'

								return aura
							end,
						},
						{
							name = 'Void Bolt',
							spellId = 205448,
							customConfig = function(aura)
								aura.triggers[2] = {
									trigger = {
										type = 'aura2',
										unit = 'player',
										debuffType = 'HELPFUL',
										auraspellids = { '194249' },
										useExactSpellId = true,
									},
								}

								aura.triggers.disjunctive = 'custom'
								aura.triggers.customTriggerLogic = 'function(t) return t[2] end'

								return aura
							end,
						},
						{
							name = 'Mind Blast',
							spellId = 8092,
							glow = {
								type = 'buff',
								auraIds = { 375981 },
							},
						},
						{
							name = 'Mind Flay',
							spellId = 15407,
							glow = {
								type = 'buff',
								auraIds = { 391401, 407468 },
								stacks = 2,
							},
							customConfig = function(aura)
								aura.conditions[1].check.trigger = 2
								aura.conditions[1].check.variable = 'show'
								aura.conditions[1].check.value = 0
								return aura
							end,
						},
						{
							name = 'Halo',
							spellId = 120644,
						},
						{
							name = 'Shadow Crash',
							spellId = 205385,
						},
						{
							name = 'Shadow Word: Death',
							spellId = 32379,
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
							name = 'Psychic Scream',
							spellId = 8122,
						},
						{
							name = 'Silence',
							spellId = 15487,
						},
						{
							name = 'Mind Soothe',
							spellId = 453,
						},
						{
							name = 'Dominate Mind',
							spellId = 205364,
						},
						{
							name = 'Mass Dispel',
							spellId = 32375,
						},
						{
							name = 'Dispel Magic',
							spellId = 528,
						},
						{
							name = 'Fade',
							spellId = 586,
						},
						{
							name = 'Purify Disease',
							spellId = 213634,
						},
						{
							name = 'Leap of Faith',
							spellId = 73325,
						},
						{
							name = 'Angerlic Feather',
							spellId = 121536,
						},
						{
							name = 'Power Word: Shield',
							spellId = 17,
						},
					},
				},
				{
					name = 'Defensives',
					type = 'defensives',

					icons = {
						{
							name = 'Vampiric Embrace',
							spellId = 15286,
						},
						{
							name = 'Desperate Prayer',
							spellId = 19236,
						},
						{
							name = 'Dispersion',
							spellId = 47585,
						},
					},
				},
			},
		},
	},
}
