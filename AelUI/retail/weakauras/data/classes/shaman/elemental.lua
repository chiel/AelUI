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
			spellIcon(33697), -- Blood Fury (Orc Racial)
			spells.naturesSwiftness,
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
				cond:ChangeTextText(stackText, '%3.s')

				icon.load:SpellKnown(454009, { exact = true })
			end),
			spells.lavaBurst,
			spellIcon(192222), -- Liquid Magma Totem
			spells.totemicRecall,
			spellIcon(196840, function(icon) -- Frost Shock
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)
				icon.display:SetColor({ 1, 1, 1, 0.75 })
				icon.display:SetDesaturate(true)

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
				cond:ChangeColor({ 1, 1, 1, 1 })
				cond:ChangeDesaturate(false)
				cond:ChangeTextText(stackText, '%3.s')

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(icefuryBuff, true)
				cond:ChangeColor({ 1, 1, 1, 1 })
				cond:ChangeDesaturate(false)
				cond:ChangeGlowVisibility(glow, true)
				cond:ChangeTextText(stackText, '%2.s')
			end),
			spells.flameShock,
			spells.spiritwalkersGrace,
		},
		secondary = {
			spells.windShear,
			spells.lightningLasso,
			spells.capacitorTotem,
			spells.thunderstorm,
			spells.earthbindTotem,
			spells.hex,

			spells.cleanseSpirit,
			spells.greaterPurge,
			spells.purge,
			spells.poisonCleansingTotem,
			spells.tremorTotem,

			spells.gustOfWind,
			spells.spiritWalk,
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
		tracking = {
			auraIcon('target', 'debuff', 188389, function(icon) -- Flame Shock
				icon.display:SetColor({ 1, 1, 1, 0.75 })
				icon.display:SetDesaturate(true)

				local countText = icon.display:GetSubRegion(4)
				countText:SetText('%2.unitCount')

				local flameShockCount = icon.triggers:AddAura('nameplate', 'debuff', {
					exactSpellIds = { 188389 },
					ownOnly = true,
				})

				local trigger = icon.triggers:Get(1)
				local cond = icon.conditions:Add()
				cond:CheckAuraFound(trigger, true)
				cond:ChangeColor({ 1, 1, 1, 1 })
				cond:ChangeDesaturate(false)
			end),
			auraIcon('player', 'buff', 455097, function(icon) -- Arc Discharge
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)
				icon.display:SetColor({ 1, 1, 1, 0.75 })
				icon.display:SetDesaturate(true)

				local trigger = icon.triggers:Get(1)

				local cond = icon.conditions:Add()
				cond:CheckAuraFound(trigger, true)
				cond:ChangeColor({ 1, 1, 1, 1 })
				cond:ChangeDesaturate(false)
				cond:ChangeGlowVisibility(glow, true)

				icon.load:SpellKnown(455096)
			end),
			auraIcon('player', 'buff', 384088, function(icon) -- Echoes of the Great Sundering
				icon.display:SetColor({ 1, 1, 1, 0.75 })
				icon.display:SetDesaturate(true)

				local trigger = icon.triggers:Get(1)
				local cond = icon.conditions:Add()
				cond:CheckAuraFound(trigger, true)
				cond:ChangeColor({ 1, 1, 1, 1 })
				cond:ChangeDesaturate(false)

				icon.load:SpellKnown(384087)
			end),
			auraIcon('target', 'debuff', 197209, function(icon) -- Lightning Rod
				icon.display:SetColor({ 1, 1, 1, 0.75 })
				icon.display:SetDesaturate(true)

				local countText = icon.display:GetSubRegion(4)
				countText:SetText('%2.unitCount')

				local flameShockCount = icon.triggers:AddAura('nameplate', 'debuff', {
					exactSpellIds = { 197209 },
					ownOnly = true,
				})

				local trigger = icon.triggers:Get(1)
				local cond = icon.conditions:Add()
				cond:CheckAuraFound(trigger, true)
				cond:ChangeColor({ 1, 1, 1, 1 })
				cond:ChangeDesaturate(false)

				icon.load:SpellKnown(210689)
			end),
		},
		reminders = {
			spellIcon(2825, function(icon) -- Bloodlust
				local satedSpellIds = { 57724, 80354, 264689, 390435 }

				icon.display:SetCooldown(false)
				icon.display:Delete(4)
				local text = icon.display:GetSubRegion(3)
				text:SetText('LUST')
				local glow = icon.display:AddGlow('proc', { enabled = true, startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive(
					'custom',
					'function(t) return t[1] and t[2] and (t[3] or (t[4] and t[5])) end'
				)
				local cooldownTrigger = icon.triggers:Get(1)
				cooldownTrigger:SetShow('onReady')
				local debuffTrigger = icon.triggers:AddAura('player', 'debuff', {
					exactSpellIds = satedSpellIds,
					show = 'onMissing',
				})
				icon.triggers:AddEvent('combat:entering', { duration = 10 })
				icon.triggers:AddUnitCharacteristics('player', { inCombat = true })
				icon.triggers:AddCombatLog({
					subevent = { 'spell', 'aura_removed' },
					destinationUnit = 'player',
					spellIds = satedSpellIds,
				})
			end),
			reminderIcon(462854), -- Skyfury
			reminderIcon(383648), -- Earth Shield
			reminderIcon(192106), -- Lightning Shield
		},
	},
})
