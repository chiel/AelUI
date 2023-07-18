local addon = select(2, ...)

local addEssenceBurst = function(spell)
	spell.glow = {
		type = 'buff',
		auraIds = { 359618 },
	}
	spell.customConfig = function(aura)
		aura.triggers[2] = {
			trigger = {
				type = 'aura2',
				unit = 'player',
				debuffType = 'HELPFUL',
				auraspellids = { '359618' },
				useExactSpellId = true,
			},
		}

		aura.subRegions[4].text_text = '%2.s'

		return aura
	end
	return spell
end

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
							buffId = 375087,
							glow = {
								type = 'buff',
								auraIds = { 375087 },
							},
						},
						{
							name = 'Deep Breath',
							spellId = 357210,
						},
						{
							name = 'Tip the Scales',
							spellId = 370553,
							glow = {
								type = 'buff',
								auraIds = { 370553 },
							},
						},
						{
							name = 'Shattering Star',
							spellId = 370452,
						},
						{
							name = 'Fire Breath',
							spellId = 357208,
						},
						{
							name = 'Eternity Surge',
							spellId = 359073,
						},
						addEssenceBurst {
							name = 'Disintegrate',
							spellId = 356995,
						},
						{
							name = 'Living Flame',
							spellId = 361469,
							glow = {
								type = 'buff',
								auraIds = { 357802 },
							},
						},
						addEssenceBurst {
							name = 'Pyre',
							spellId = 357211,
						},
						{
							name = 'Unravel',
							spellId = 368432,
							glow = {
								type = 'overlay',
							},
							customConfig = function(aura)
								aura.conditions[1].check.variable = 'OR'
								aura.conditions[1].check.checks[2] = {
									trigger = 2,
									variable = 'show',
									value = 0,
								}

								table.insert(aura.conditions, {
									check = {
										trigger = 2,
										variable = 'show',
										value = 1,
									},
									changes = {
										{
											property = 'sub.2.glow',
											value = true,
										},
									},
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
							name = 'Quell',
							spellId = 351338,
						},
						{
							name = 'Sleep Walk',
							spellId = 360806,
						},
						{
							name = 'Tail Swipe',
							spellId = 368970,
						},
						{
							name = 'Wing Buffet',
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
							name = 'Oppressing Roar',
							spellId = 372048,
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
							name = 'Time Spiral',
							spellId = 374968,
						},
						{
							name = 'Hover',
							spellId = 358267,
							glow = {
								type = 'overlay',
							},
						},
						{
							name = 'Rescue',
							spellId = 370665,
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
