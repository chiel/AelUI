local _, ns = ...

local wa = ns.weakauras
local auraIcon = wa.auraIcon
local spellIcon = wa.spellIcon
local spells = wa.data.classes.priest.spells

table.insert(ns.weakauras.data.classes.priest.specs, {
	specId = 258, -- Shadow

	groups = {
		primary = {
			spellIcon(34433), -- Shadowfiend
			spells.powerInfusion,
			spells.mindgames,
			spellIcon(263165), -- Void Torrent
			spellIcon(391109), -- Dark Ascension
			spellIcon(228260, function(icon) -- Void Eruption
				icon.triggers:SetDisjunctive('custom', 'function(t) return t[2] end')
				icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { voidformId },
					show = 'onMissing',
				})
			end),
			spellIcon(205448, function(icon) -- Void Bolt
				icon.triggers:SetDisjunctive('custom', 'function(t) return t[2] end')
				icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { voidformId },
					show = 'onActive',
				})
			end),
			spells.mindBlast,
			spellIcon(15407, function(icon) -- Mind Flay
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local trigger = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 391401, 407468 },
					show = 'onActive',
				})

				local cond = icon.conditions:Get(1)
				cond:CheckTriggerActive(trigger, false)

				local cond = icon.conditions:Add()
				cond:CheckStacks(trigger, '>=', 2)
				cond:ChangeGlowVisibility(glow, true)
			end),
			spells.shadowWordDeath,
			spells.halo,
			spells.divineStar,
			spellIcon(205385), -- Shadow Crash
		},
		secondary = {
			spellIcon(15487), -- Silence
			spells.psychicScream,
			spells.dominateMind,
			spells.mindSoothe,
			spells.massDispel,
			spells.fade,
			spells.dispelMagic,
			spells.purifyDisease,
			spells.leapOfFaith,
			spells.angelicFeather,
			spells.powerWordShield,
		},
		defensives = {
			spells.vampiricEmbrace,
			spells.desperatePrayer,
			spellIcon(47585), -- Dispersion
		},
		tracking = {
			auraIcon('target', 'debuff', 34914), -- Vampric Touch
			auraIcon('target', 'debuff', 589), -- Shadow Word: Pain
			auraIcon('target', 'debuff', 335467, function(icon) -- Devouring Plague
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local trigger = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 373204 }, -- Mind Devourer
					show = 'onActive',
				})

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(trigger, true)
				cond:ChangeGlowVisibility(glow, true)
			end),
		},
	},
})
