local ns = select(2, ...)

local wa = ns.weakauras
local spellIcon = wa.createSpellIconBuilder

ns.weakauras.classes.monk = {
	name = 'Monk',
	icon = 626002,
	specs = {},

	spells = {
		dampenHarm = spellIcon(122278),
		detox = spellIcon(218164),
		diffuseMagic = spellIcon(122783),
		fortifyingBrew = spellIcon(115203),
		legSweep = spellIcon(119381),
		paralysis = spellIcon(115078),
		provoke = spellIcon(115546),
		ringOfPeace = spellIcon(116844),
		roll = spellIcon(109132),
		spearHandStrike = spellIcon(116705),
		tigersLust = spellIcon(116841),
		transcendence = spellIcon(101643),
		transcendenceTransfer = spellIcon(119996),

		touchOfDeath = spellIcon(322109, function(icon)
			local glow = icon.display:AddGlow('proc', { startAnimation = true })
			icon.display:Move(glow, 3)
			icon.display:SetColor({ 1, 1, 1, 0.75 })
			icon.display:SetDesaturate(true)

			icon.triggers:SetDisjunctive('any')
			local trigger = icon.triggers:AddSpellActivationOverlay(322109)

			local cond = icon.conditions:Add()
			cond:CheckTriggerActive(trigger, true)
			cond:ChangeColor({ 1, 1, 1, 1 })
			cond:ChangeDesaturate(false)
			cond:ChangeGlowVisibility(glow, true)
		end),
	},
}
