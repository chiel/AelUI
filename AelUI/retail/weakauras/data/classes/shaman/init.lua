local _, ns = ...

local wa = ns.weakauras
local spellIcon = wa.spellIcon

ns.weakauras.data.classes.shaman = {
	name = 'Shaman',
	icon = 626006,
	specs = {},

	spells = {
		ancestralGuidance = spellIcon(108281),
		astralShift = spellIcon(108271),
		capacitorTotem = spellIcon(192058),
		cleanseSpirit = spellIcon(51886),
		earthElemental = spellIcon(198103),
		earthbindTotem = spellIcon(2484),
		earthgrabTotem = spellIcon(51485),
		flameShock = spellIcon(188389),
		frostShock = spellIcon(196840),
		greaterPurge = spellIcon(378773),
		gustOfWind = spellIcon(192063),
		healingStreamTotem = spellIcon(5394),
		hex = spellIcon(51514),
		lavaBurst = spellIcon(51505, function(icon)
			local glow = icon.display:AddGlow('proc', { startAnimation = true })
			icon.display:Move(glow, 3)

			icon.triggers:SetDisjunctive('any')
			local trigger = icon.triggers:AddAura('player', 'buff', {
				exactSpellIds = { 77762 }, -- Lava Surge
				show = 'onActive',
			})

			local cond = icon.conditions:Add()
			cond:CheckTriggerActive(trigger, true)
			cond:ChangeGlowVisibility(glow, true)
		end),
		lightningLasso = spellIcon(305483),
		naturesSwiftness = spellIcon(378081, function(icon)
			local glow = icon.display:AddGlow('proc', { startAnimation = true })
			icon.display:Move(glow, 3)

			icon.triggers:SetDisjunctive('any')
			local trigger = icon.triggers:AddAura('player', 'buff', {
				exactSpellIds = { 378081 }, -- Lava Surge
				show = 'onActive',
			})

			local cond = icon.conditions:Add()
			cond:CheckTriggerActive(trigger, true)
			cond:ChangeGlowVisibility(glow, true)
		end),
		poisonCleansingTotem = spellIcon(383013),
		primalStrike = spellIcon(73899),
		purge = spellIcon(370),
		skyfury = spellIcon(462854),
		spiritWalk = spellIcon(58875),
		spiritwalkersGrace = spellIcon(79206),
		stoneBulwarkTotem = spellIcon(108270),
		thunderstorm = spellIcon(51490),
		totemicProjection = spellIcon(108287),
		totemicRecall = spellIcon(108285),
		tremorTotem = spellIcon(8143),
		windRushTotem = spellIcon(192077),
		windShear = spellIcon(57994),
	},
}
