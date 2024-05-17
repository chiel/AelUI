local ns = select(2, ...)

local wa = ns.weakauras
local consumableIcon = wa.createConsumableIconBuilder
local itemIcon = wa.createItemIconBuilder
local spellIcon = wa.createSpellIconBuilder
local consumables = wa.consumables
local racials = wa.racials
local spells = wa.classes.monk.spells

table.insert(ns.weakauras.classes.monk.specs, {
	specId = 269, -- Windwalker

	groups = {
		primary = {
			spellIcon(123904), -- Invoke Xuen, the White Tiger
			spellIcon(137639), -- Storm, Earth, and Fire
			spellIcon(152173), -- Serenity
			spellIcon(386276), -- Bonedust Brew
			spellIcon(152175), -- Whirling Dragon Punch
			spellIcon(392983), -- Strike of the Windlord
			spells.touchOfDeath,
			spellIcon(116847), -- Rushing Jade Wind
			spellIcon(113656), -- Fists of Fury
			spellIcon(100780, function(icon) -- Tiger Palm
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local trigger = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 129914 }, -- Power Strikes
					show = 'onActive',
				})

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(trigger, true)
				cond:ChangeGlowVisibility(glow, true)
			end),
			spellIcon(100784, function(icon) -- Blackout Kick
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
				cond:CheckStacks(trigger, '==', 3)
				cond:ChangeGlowVisibility(glow, true)
			end),
			spells.risingSunKick,
			spellIcon(101546, function(icon) -- Spinning Crane Kick
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local trigger = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 325202 }, -- Dance of Chi'Ji
					show = 'onActive',
				})

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(trigger, true)
				cond:ChangeGlowVisibility(glow, true)
			end),
			spellIcon(388193), -- Jadefire Stomp
		},
		secondary = {
			spells.spearHandStrike,
			spells.legSweep,
			spells.paralysis,
			spells.ringOfPeace,
			spells.provoke,
			racials.arcaneTorrent,
			spells.detox,
			spells.roll,
			spells.tigersLust,
			spellIcon(101545), -- Flying Serpent Kick
			spells.transcendence,
			spells.transcendenceTransfer,
		},
		defensives = {
			spellIcon(122470), -- Touch of Karma
			spells.dampenHarm,
			spells.diffuseMagic,
			spells.fortifyingBrew,
		},
		consumables = {
			consumables.dreamwalkersHealingPotion,
			consumables.healthstone,
			consumables.elementalPotionOfUltimatePower,
			consumables.potionOfTheHushedZephyr,
		},
	},
})
