local addon = select(2, ...)

-- PALADIN
-- Avenging Wrath 31884
-- Blessing of Freedom 1044
-- Blessing of Protection 1022
-- Blessing of Sacrifice 6940
-- Blinding Light 115750
-- Consecration 26573
-- Crusader Strike 35395
-- Divine Shield 642
-- Divine Steed 190784
-- Divine Toll 375576
-- Hammer of Justice 853
-- Hammer of Wrath 24275
-- Hand of Reckoning 62124
-- Intercession 391054 -- bres indicator
-- Judgment 20271 / 275779
-- Lay on Hands 633
-- Rebuke 96231
-- Shield of the Righteous 53600

-- PROTECTION
-- Ardent Defender 31850
-- Avenger's Shield 31935
-- Blessed Hammer --> Crusader Strike
-- Cleanse Toxins 213644
-- Eye of Tyr 387174
-- Guardian of Ancient Kings 86659

-- RETRIBUTION
-- Blade of Justice 184575
-- Cleanse Toxins 213644
-- Divine Protection 498 / 403876
-- Divine Storm 53385
-- Final Reckoning 343721
-- Final Verdict 383328 / Templar's Verdict 85256
-- Shield of Vengeance 184662
-- Templar Strike --> Crusader Strike
-- Wake of Ashes 255937

addon.weakauras.classes.paladin = {
	name = 'Paladin',
	icon = 626003,

	specs = {
		{
			name = 'Protection',
			icon = 236264,
			specId = 66,

			spells = {
				-- Shield of the Righteous 53600
				{
					name = 'Primary',
					type = 'primary',

					icons = {
						{
							name = 'Avenging Wrath',
							spellId = 31884,
						},
						{
							name = 'Eye of Tyr',
							spellId = 387174,
						},
						{
							name = 'Divine Toll',
							spellId = 375576,
						},
						{
							name = 'Consecration',
							spellId = 26573,
						},
						{
							name = 'Judgment',
							spellId = 20271,
						},
						{
							name = 'Crusader Strike',
							spellId = 35395,
						},
						{
							name = 'Avenger\'s Shield',
							spellId = 31935,
						},
						{
							name = 'Hammer of Wrath',
							spellId = 24275,
						},
					},
				},
				{
					name = 'Secondary',
					type = 'secondary',

					icons = {
						{
							name = 'Rebuke',
							spellId = 96231,
						},
						{
							name = 'Hammer of Justice',
							spellId = 853,
						},
						{
							name = 'Blinding Light',
							spellId = 115750,
						},
						{
							name = 'Divine Steed',
							spellId = 190784,
						},
						{
							name = 'Hand of Reckoning',
							spellId = 62124,
						},
						{
							name = 'Cleanse Toxins',
							spellId = 213644,
						},
						{
							name = 'Blessing of Freedom',
							spellId = 1044,
						},
						{
							name = 'Blessing of Protection',
							spellId = 1022,
						},
						{
							name = 'Blessing of Sacrifice',
							spellId = 6940,
						},
					},
				},
				{
					name = 'Defensives',
					type = 'defensives',

					icons = {
						{
							name = 'Lay on Hands',
							spellId = 633,
						},
						{
							name = 'Divine Shield',
							spellId = 642,
						},
						{
							name = 'Guardian of Ancient Kings',
							spellId = 86659,
						},
						{
							name = 'Ardent Defender',
							spellId = 31850,
						},
					},
				},
			},
		},
		{
			name = 'Retribution',
			icon = 0,
			specId = 70,

			spells = {
				{
					name = 'Primary',
					type = 'primary',

					icons = {
						{
							name = 'Avenging Wrath',
							spellId = 31884,
						},
						{
							name = 'Execution Sentence',
							spellId = 343527,
						},
						{
							name = 'Final Reckoning',
							spellId = 343721,
						},
						{
							name = 'Divine Toll',
							spellId = 375576,
						},
						{
							name = 'Wake of Ashes',
							spellId = 255937,
						},
						{
							name = 'Hammer of Wrath',
							spellId = 24275,
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
							name = 'Judgment',
							spellId = 20271,
						},
						{
							name = 'Blade of Justice',
							spellId = 184575,
						},
						{
							name = 'Crusader Strike',
							spellId = 35395,
						},
					},
				},
				{
					name = 'Secondary',
					type = 'secondary',

					icons = {
						{
							name = 'Rebuke',
							spellId = 96231,
						},
						{
							name = 'Hammer of Justice',
							spellId = 853,
						},
						{
							name = 'Blinding Light',
							spellId = 115750,
						},
						{
							name = 'Divine Steed',
							spellId = 190784,
						},
						{
							name = 'Hand of Reckoning',
							spellId = 62124,
						},
						{
							name = 'Cleanse Toxins',
							spellId = 213644,
						},
						{
							name = 'Blessing of Freedom',
							spellId = 1044,
						},
						{
							name = 'Blessing of Protection',
							spellId = 1022,
						},
						{
							name = 'Blessing of Sacrifice',
							spellId = 6940,
						},
					},
				},
				{
					name = 'Defensives',
					type = 'defensives',

					icons = {
						{
							name = 'Lay on Hands',
							spellId = 633,
						},
						{
							name = 'Divine Shield',
							spellId = 642,
						},
						{
							name = 'Shield of Vengeance',
							spellId = 184662,
						},
						{
							name = 'Divine Protection',
							spellId = 498,
						},
					},
				},
			},
		},
	},
}
