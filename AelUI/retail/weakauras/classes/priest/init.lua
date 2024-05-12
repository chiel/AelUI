local ns = select(2, ...)

local wa = ns.weakauras
local spellIcon = wa.createSpellIconBuilder

ns.weakauras.classes.priest = {
	name = 'Priest',
	icon = 626004,
	specs = {},

	spells = {
		angelicFeather = spellIcon(121536),
		desperatePrayer = spellIcon(19236),
		dispelMagic = spellIcon(528),
		divineStar = spellIcon(122121),
		dominateMind = spellIcon(205364),
		fade = spellIcon(586),
		halo = spellIcon(120644),
		leapOfFaith = spellIcon(73325),
		massDispel = spellIcon(32375),
		mindSoothe = spellIcon(453),
		mindgames = spellIcon(375901),
		powerInfusion = spellIcon(10060),
		powerWordShield = spellIcon(17),
		psychicScream = spellIcon(8122),
		purifyDisease = spellIcon(213634),
		shadowWordPain = spellIcon(589),
		vampiricEmbrace = spellIcon(15286),

		mindBlast = spellIcon(8092, function(icon)
			local glow = icon.display:AddGlow('proc', { startAnimation = true })
			icon.display:Move(glow, 3)

			icon.triggers:SetDisjunctive('any')
			local trigger = icon.triggers:AddAura('player', 'buff', {
				exactSpellIds = { 375981 },
				show = 'onActive',
			})

			local cond = icon.conditions:Add()
			cond:CheckTriggerActive(trigger, true)
			cond:ChangeGlowVisibility(glow, true)
		end),
		shadowWordDeath = spellIcon(32379, function(icon)
			local glow = icon.display:AddGlow('proc', { startAnimation = true })
			icon.display:Move(glow, 3)

			icon.triggers:SetDisjunctive('any')
			local trigger = icon.triggers:AddSpellActivationOverlay(32379)

			local cond = icon.conditions:Add()
			cond:CheckTriggerActive(trigger, true)
			cond:ChangeGlowVisibility(glow, true)
		end),
	},
}
