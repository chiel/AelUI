local ns = select(2, ...)

local wa = ns.weakauras
local spellIcon = wa.createSpellIconBuilder

ns.weakauras.classes.paladin = {
	name = 'Paladin',
	icon = 626003,
	specs = {},

	spells = {
		avengingWrath = spellIcon(31884),
		blessingOfFreedom = spellIcon(1044),
		blessingOfProtection = spellIcon(1022),
		blessingOfSacrifice = spellIcon(6940),
		blindingLight = spellIcon(115750),
		cleanseToxins = spellIcon(213644),
		divineShield = spellIcon(642),
		divineSteed = spellIcon(190784),
		divineToll = spellIcon(375576),
		hammerOfJustice = spellIcon(853),
		handOfReckoning = spellIcon(62124),
		judgment = spellIcon(20271),
		layOnHands = spellIcon(633),
		rebuke = spellIcon(96231),

		hammerOfWrath = spellIcon(24275, function(icon)
			local glow = icon.display:AddGlow('proc', { startAnimation = true })
			icon.display:Move(glow, 3)

			icon.triggers:SetDisjunctive('any')
			local trigger = icon.triggers:AddSpellActivationOverlay(24275)

			local cond = icon.conditions:Add()
			cond:CheckTriggerActive(trigger, true)
			cond:ChangeGlowVisibility(glow, true)
			icon.conditions:Move(cond, 1)

			local cond = icon.conditions:Add()
			cond:CheckTriggerActive(trigger, false)
			cond:ChangeColor({ 1, 1, 1, 0.75 })
			cond:ChangeDesaturate(true)
			icon.conditions:Move(cond, 2)
		end),
	},
}
