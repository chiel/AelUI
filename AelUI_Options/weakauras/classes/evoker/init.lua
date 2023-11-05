local addon = select(2, ...)

local essenceBurstAuraId = {
	augmentation = 392268,
	devastation = 359618,
}

local addEssenceBurst = function(spec, spell)
	local auraId = essenceBurstAuraId[spec]

	spell.glow = {
		type = 'buff',
		auraIds = { auraId },
	}
	spell.customConfig = function(aura)
		aura.triggers[2] = {
			trigger = {
				type = 'aura2',
				unit = 'player',
				debuffType = 'HELPFUL',
				auraspellids = { tostring(auraId) },
				useExactSpellId = true,
			},
		}

		aura.subRegions[4].text_text = '%2.s'

		return aura
	end
	return spell
end

local secondary = {
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
			glow = {
				type = 'buff',
				auraIds = { 406043 },
			},
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
}

local defensives = {
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
}

local consumables = {
	name = 'Consumables',
	type = 'consumables',

	icons = {
		addon.weakauras.shared.refreshingHealingPotion,
	},
}

addon.weakauras.classes.evoker = {
	name = 'Evoker',
	icon = 4574311,

	specs = {
		{
			name = 'Augmentation',
			icon = 5198700,
			specId = 1473,

			auraBars = {
				{
					name = 'Hover',
					auraId = 358267,
					color = { 175, 175, 175 },
				},
				{
					name = 'Ebon Might',
					auraId = 395296,
					color = { 245, 215, 70 },
					pandemic = 3.75,
				},
			},

			spells = {
				{
					name = 'Primary',
					type = 'primary',

					icons = {
						{
							name = 'Time Skip',
							spellId = 404977,
							customConfig = function(aura)
								aura.load = {
									use_not_spellknown = true,
									not_spellknown = 412713,
								}
								return aura
							end,
						},
						{
							name = 'Breath of Eons',
							spellId = 403631,
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
							name = 'Prescience',
							spellId = 409311,
						},
						{
							name = 'Ebon Might',
							spellId = 395152,
						},
						{
							name = 'Fire Breath',
							spellId = 382266,
						},
						{
							name = 'Upheaval',
							spellId = 408092,
						},
						addEssenceBurst('augmentation', {
							name = 'Eruption',
							spellId = 395160,
							-- glow = {
							-- 	type = 'overlay',
							-- },
						}),
						{
							name = 'Blistering Scales',
							spellId = 360827,
							glow = {
								type = 'buff',
								auraIds = { 360827 },
								unit = 'group',
								missing = true,
							},
							customConfig = function(aura)
								aura.subRegions[4].text_text = '%2.s'
								return aura
							end,
						},
						{
							name = 'Living Flame',
							spellId = 361469,
							glow = {
								type = 'buff',
								auraIds = { 370901 },
							},

							customConfig = function(aura)
								aura.triggers[3] = {
									trigger = {
										type = 'aura2',
										unit = 'player',
										debuffType = 'HELPFUL',
										auraspellids = { '372470' },
										useExactSpellId = true,
										fetchTooltip = true,
									},
								}
								aura.subRegions[3].text_text = '%3.tooltip1'
								aura.subRegions[3]['text_text_format_3.tooltip1_format'] = 'BigNumber'
								aura.subRegions[4].text_text = '%2.s'

								return aura
							end,
						},
					},
				},
				secondary,
				defensives,
				consumables,
			},
		},
		{
			name = 'Devastation',
			icon = 4511811,
			specId = 1467,

			auraBars = {
				{
					name = 'Hover',
					auraId = 358267,
					color = { 175, 175, 175 },
				},
			},

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
						addEssenceBurst('devastation', {
							name = 'Disintegrate',
							spellId = 356995,
						}),
						{
							name = 'Living Flame',
							spellId = 361469,
							glow = {
								type = 'buff',
								auraIds = { 375802 },
							},

							customConfig = function(aura)
								aura.subRegions[4].text_text = '%2.s'

								return aura
							end,
						},
						addEssenceBurst('devastation', {
							name = 'Pyre',
							spellId = 357211,
						}),
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
				secondary,
				defensives,
			},
		},
	},
}
