local ns = select(2, ...)

local wa = ns.weakauras
local consumableIcon = wa.createConsumableIconBuilder
local itemIcon = wa.createItemIconBuilder
local spellIcon = wa.createSpellIconBuilder
local consumables = wa.consumables
local racials = wa.racials
local spells = wa.classes.monk.spells

table.insert(ns.weakauras.classes.monk.specs, {
	specId = 270, -- Mistweaver

	groups = {
		primary = {
			spellIcon(325197), -- Invoke Chi-Ji, the Red Crane,
			spellIcon(322118), -- Invoke Yu'lon, the Jade Serpent,
			spellIcon(116849), -- Life Cocoon,
			spellIcon(115310), -- Revival,
			spellIcon(124081), -- Zen Pulse,
			spellIcon(388193), -- Faeline Stomp,
			spellIcon(116680, function(icon) -- Thunder Focus Tea,
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local trigger = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 116680 }, -- Thunder Focus Tea
					show = 'onActive',
				})

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(trigger, true)
				cond:ChangeGlowVisibility(glow, true)
			end),
			spellIcon(115151, function(icon) -- Renewing Mist,
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				local trigger = icon.triggers:Get(1)

				local cond = icon.conditions:Add()
				cond:CheckCharges(trigger, '==', 2)
				cond:ChangeGlowVisibility(glow, true)
			end),
			spellIcon(116670, function(icon) -- Vivify
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local trigger = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 392883 }, -- Vivacious Vivification
					show = 'onActive',
				})

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(trigger, true)
				cond:ChangeGlowVisibility(glow, true)
			end),
			spellIcon(107428), -- Rising Sun Kick,
			spellIcon(100784, function(icon) -- Blackout Kick,
				local text = icon.display:GetSubRegion(4)
				text:SetText('%2.s')

				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local trigger = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 202090 }, -- Teachings of the Monastery
					show = 'onActive',
				})

				local cond = icon.conditions:Add()
				cond:CheckStacks(trigger, '==', 4)
				cond:ChangeGlowVisibility(glow, true)
			end),
			spellIcon(322101), -- Expel Harm,
			spellIcon(399491, function(icon) -- Sheilun's Gift,
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				local trigger = icon.triggers:Get(1)

				local cond = icon.conditions:Get(1)
				cond:CheckSpellCount(trigger, '==', 0)

				local cond = icon.conditions:Add()
				cond:CheckSpellCount(trigger, '>=', 9)
				cond:ChangeGlowVisibility(glow, true)
			end),
			spellIcon(124682), -- Enveloping Mist,
			spellIcon(191837), -- Essence Font,
		},
		secondary = {
			spells.spearHandStrike,
			spells.legSweep,
			spells.paralysis,
			spells.ringOfPeace,
			-- spells.provoke,
			racials.arcaneTorrent,
			spells.touchOfDeath,
			spells.detox,
			spells.roll,
			spells.tigersLust,
			spells.transcendence,
			spells.transcendenceTransfer,
		},
		defensives = {
			spells.dampenHarm,
			spells.diffuseMagic,
			spells.fortifyingBrew,
		},
		tracking = {
			spellIcon(115294, function(icon)
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local trigger = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 115867 }, -- Mana Tea
					show = 'onActive',
				})

				local cond = icon.conditions:Get(1)
				cond:CheckTriggerActive(trigger, false)

				local cond = icon.conditions:Add()
				cond:CheckStacks(trigger, '==', 20)
				cond:ChangeGlowVisibility(glow, true)
			end),
		},
		consumables = {
			consumables.dreamwalkersHealingPotion,
			consumables.healthstone,
			consumables.elementalPotionOfUltimatePower,
			consumables.potionOfTheHushedZephyr,
		},
	},
})
