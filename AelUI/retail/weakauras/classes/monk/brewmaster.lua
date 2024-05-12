local ns = select(2, ...)

local wa = ns.weakauras
local consumableIcon = wa.createConsumableIconBuilder
local itemIcon = wa.createItemIconBuilder
local spellIcon = wa.createSpellIconBuilder
local consumables = wa.consumables
local racials = wa.racials
local spells = wa.classes.monk.spells

table.insert(ns.weakauras.classes.monk.specs, {
	name = 'Brewmaster',
	icon = 608951,
	specId = 268,

	groups = {
		primary = {
			spellIcon(132578), -- Invoke Niuzao, the Black Ox
			spellIcon(387184), -- Weapons of Order
			spellIcon(325153), -- Exploding Keg
			spellIcon(388686), -- Summon White Tiger Statue
			itemIcon(202569), -- Djaruun, Pillar of the Elder Flame
			spellIcon(386276), -- Bonedust Brew
			spells.touchOfDeath,
			spellIcon(205523), -- Blackout Kick
			spellIcon(115181), -- Breath of Fire
			spellIcon(121253), -- Keg Smash
			spellIcon(107428), -- Rising Sun Kick
			spellIcon(115098), -- Chi Wave
			spellIcon(322101), -- Expel Harm
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
			spells.transcendence,
			spells.transcendenceTransfer,
		},
		defensives = {
			spellIcon(115176), -- Zen Meditation
			spells.dampenHarm,
			spells.diffuseMagic,
			spells.fortifyingBrew,
		},
		consumables = {
			consumables.dreamwalkersHealingPotion,
			consumables.healthstone,
			consumables.elementalPotionOfUltimatePower,
			consumables.potionOfShockingDisclosure,
			consumables.potionOfTheHushedZephyr,
		},
		tracking = {
			spellIcon(119582, function(icon) -- Purifying Brew
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local cooldown = icon.triggers:Get(1)
				local staggerBuff = icon.triggers:AddAura('player', 'debuff', {
					exactSpellIds = { 124275, 124274, 124273 },
				})

				local cond = icon.conditions:Add()
				cond:CheckOnCooldown(cooldown, false)
				cond:ChangeGlowVisibility(glow, true)

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(staggerBuff, false)
				cond:ChangeGlowVisibility(glow, false)
			end),
			spellIcon(322507, function(icon) -- Celestial Brew
				local stackText = icon.display:GetSubRegion(4)
				stackText:SetText('%2.s')

				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local purifiedChi = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 325092 },
				})

				local cond = icon.conditions:Add()
				cond:CheckStacks(purifiedChi, '==', 10)
				cond:ChangeGlowVisibility(glow, true)
			end),
		},
	},
})
