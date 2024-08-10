local _, ns = ...

local wa = ns.weakauras
local spellIcon = wa.spellIcon
local spells = wa.data.classes.monk.spells

table.insert(ns.weakauras.data.classes.monk.specs, {
	specId = 268, -- Brewmaster

	groups = {
		primary = {
			spellIcon(387184), -- Weapons of Order
			spellIcon(325153), -- Exploding Keg
			spellIcon(132578), -- Invoke Niuzao, the Black Ox
			spells.touchOfDeath,
			spellIcon(116847), -- Rushing Jade Wind
			spells.blackoutKick,
			spellIcon(115181), -- Breath of Fire
			spellIcon(121253), -- Keg Smash
			spells.risingSunKick,
			spells.chiBurst,
			spells.expelHarm,
		},
		secondary = {
			spells.spearHandStrike,
			spells.legSweep,
			spells.paralysis,
			spells.ringOfPeace,
			spells.songOfChiJi,
			spells.provoke,
			spellIcon(115315), -- Summon Black Ox Statue
			spellIcon(218164), -- Detox
			spells.clash,
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
		tracking = {
			spellIcon(115399), -- Black Ox Brew
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
