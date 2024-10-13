local _, ns = ...

local wa = ns.weakauras
local auraIcon = wa.auraIcon
local spellIcon = wa.spellIcon
local spells = wa.data.classes.shaman.spells

table.insert(ns.weakauras.data.classes.shaman.specs, {
	specId = 262, -- Elemental

	groups = {
		primary = {
			spellIcon(114050), -- Ascendance
			spellIcon(198067), -- Fire Elemental
			spellIcon(191634, function(icon) -- Stormkeeper
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local trigger = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 191634 },
					ownOnly = true,
				})
				icon.triggers:Move(trigger, 1)

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(trigger, true)
				cond:ChangeColor({ 1, 1, 1, 1 })
				cond:ChangeDesaturate(false)
				cond:ChangeInverse(false)
				cond:ChangeGlowVisibility(glow, true)
			end),
			spellIcon(192249), -- Storm Elemental
			spellIcon(375982, function(icon) -- Primordial Wave
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local trigger = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 375986 }, -- Lava Surge
					show = 'onActive',
				})
				icon.triggers:Move(trigger, 1)

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(trigger, true)
				cond:ChangeDesaturate(false)
				cond:ChangeGlowVisibility(glow, true)
				cond:ChangeInverse(false)
			end),
			spells.lavaBurst,
			spellIcon(192222), -- Liquid Magma Totem
			spells.flameShock,
			spells.naturesSwiftness,
			spells.totemicRecall,
			spellIcon(196840, function(icon) -- Frost Shock
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local icefuryBuff = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 462818 },
					ownOnly = true,
				})

				local frostShockBuff = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 210714 },
					ownOnly = true,
				})

				local stackText = icon.display:GetSubRegion(5)

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(frostShockBuff, true)
				cond:ChangeGlowVisibility(glow, true)
				cond:ChangeTextText(stackText, '%3.s')

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(icefuryBuff, true)
				cond:ChangeGlowVisibility(glow, true)
				cond:ChangeTextText(stackText, '%2.s')
			end),
		},
		secondary = {
			spells.windShear,
			spells.lightningLasso,
			spells.capacitorTotem,
			spells.thunderstorm,
			spells.earthbindTotem,
			spells.earthgrabTotem,
			spells.hex,

			spells.cleanseSpirit,
			spells.greaterPurge,
			spells.purge,
			spells.poisonCleansingTotem,
			spells.tremorTotem,

			spells.gustOfWind,
			spells.spiritWalk,
			spells.spiritwalkersGrace,
			spells.windRushTotem,

			spells.totemicProjection,
		},
		defensives = {
			spells.stoneBulwarkTotem,
			spells.healingStreamTotem,
			spells.earthElemental,
			spells.ancestralGuidance,
			spells.astralShift,
		},
		tracking = {},
		reminders = {
			function(idPrefix, config)
				local spellInfo = C_Spell.GetSpellInfo(462854) -- Skyfury
				local id = idPrefix .. ' - ' .. spellInfo.name
				local icon = wa.icon(id, config)
				icon.display:SetCooldown({ inverse = false })
				local trigger = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 462854 },
					show = 'onMissing',
				})

				icon.animations:Start('preset', 'fade')
				icon.animations:Main('preset', 'flash')
				icon.animations:Finish('preset', 'fade')
				return icon
			end,
			function(idPrefix, config)
				local spellInfo = C_Spell.GetSpellInfo(192106) -- Lightning Shield
				local id = idPrefix .. ' - ' .. spellInfo.name
				local icon = wa.icon(id, config)
				icon.display:SetCooldown({ inverse = false })
				local trigger = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 192106 },
					show = 'onMissing',
				})

				icon.animations:Start('preset', 'fade')
				icon.animations:Main('preset', 'flash')
				icon.animations:Finish('preset', 'fade')
				return icon
			end,
		},
	},
})
