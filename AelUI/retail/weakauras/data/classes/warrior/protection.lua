local _, ns = ...

local wa = ns.weakauras
local spellIcon = wa.spellIcon
local spells = wa.data.classes.warrior.spells

table.insert(ns.weakauras.data.classes.warrior.specs, {
	specId = 73, -- Protection

	groups = {
		primary = {
			spellIcon(401150), -- Avatar
			spellIcon(228920), -- Ravager
			spellIcon(376079), -- Champion's Spear
			spellIcon(23920), -- Spell Reflection
			spellIcon(1160), -- Demoralizing Shout
			spellIcon(385952), -- Shield Charge
			spellIcon(163201, function(icon) -- Execute
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)
				icon.display:SetColor({ 1, 1, 1, 0.75 })
				icon.display:SetDesaturate(true)

				local trigger = icon.triggers:Get(1)

				local cond = icon.conditions:Add()
				cond:CheckSpellUsable(trigger, true)
				cond:ChangeDesaturate(false)
				cond:ChangeGlowVisibility(glow, true)
			end),
			spellIcon(6343, function(icon) -- Thunder Clap
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)
				local stackText = icon.display:GetSubRegion(5)

				icon.triggers:SetDisjunctive('any')
				local trigger = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 435615 }, -- Thunder Blast
					ownOnly = true,
				})

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(trigger, true)
				cond:ChangeGlowVisibility(glow, true)
				cond:ChangeTextText(stackText, '%2.s')
			end),
			spellIcon(23922), -- Shield Slam
			spellIcon(6572, function(icon) -- Revenge
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local trigger = icon.triggers:AddSpellActivationOverlay(6572)

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(trigger, true)
				cond:ChangeGlowVisibility(glow, true)
			end),
		},
		secondary = {
			spellIcon(6552), -- Pummel
			spellIcon(107570), -- Storm Bolt
			spellIcon(5246), -- Intimidating Shout
			spellIcon(46968), -- Shockwave
			spellIcon(18499), -- Berserker Rage
			spellIcon(355), -- Taunt
			spellIcon(1161), -- Challenging Shout
			spellIcon(202168), -- Impending Victory
			spellIcon(100), -- Charge
			spellIcon(3411), -- Intervene
			spellIcon(6544), -- Heroic Leap
		},
		defensives = {
			spellIcon(392966), -- Spell Block
			spellIcon(97462), -- Rallying Cry
			spellIcon(871), -- Shield Wall
			spellIcon(12975), -- Last Stand
		},
	},
})
