local _, ns = ...

local wa = ns.weakauras
local auraIcon = wa.auraIcon
local reminderIcon = wa.reminderIcon
local spellIcon = wa.spellIcon
local spells = wa.data.classes.shaman.spells

table.insert(ns.weakauras.data.classes.shaman.specs, {
	specId = 262, -- Elemental

	groups = {
		primary = {
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
			spellIcon(198067), -- Fire Elemental
			spellIcon(192249), -- Storm Elemental
			spellIcon(114050), -- Ascendance
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
			spellIcon(188196, function(icon) -- Lightning Bolt
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)
				icon.display:SetColor({ 1, 1, 1, 0.75 })
				icon.display:SetDesaturate(true)
				icon.display:SetIcon(5927653)

				icon.triggers:SetDisjunctive('any')
				icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 462131 }, -- Awakening Storms
					show = 'onActive',
				})

				local tempestTrigger = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 454015 }, -- Tempest
					show = 'onActive',
				})

				local stackText = icon.display:GetSubRegion(5)
				stackText:SetText('%2.s')

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(tempestTrigger, true)
				cond:ChangeColor({ 1, 1, 1, 1 })
				cond:ChangeDesaturate(false)
				cond:ChangeGlowVisibility(glow, true)

				icon.load:SpellKnown(454009, { exact = true })
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
			reminderIcon(462854), -- Skyfury
			reminderIcon(192106), -- Lightning Shield
		},
	},
})
