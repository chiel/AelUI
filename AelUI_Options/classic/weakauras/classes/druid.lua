local addon = select(2, ...)

addon.classic.weakauras.classes.druid = {
	name = 'Druid',
	icon = 625999,
	class = 'DRUID',

	groups = {
		primary = {
			{ -- Attack
				spellId = 6603,
				custom = function(aura)
					aura.display:SetColor({ 1, 1, 1, 0.5 })
					aura.display:SetDesaturate(true)

					local glow = aura.display:AddGlow('pixel', {
						color = { 1, 1, 1, 1 },
					})
					aura.display:MoveToBackground(glow)

					local trigger = aura.triggers:AddCustomStatus({
						events = 'PLAYER_ENTER_COMBAT PLAYER_LEAVE_COMBAT',
						custom = 'function() return IsCurrentSpell(6603) end',
					})
					aura.triggers:SetDisjunctive('any')

					local cond = aura.conditions:Add()
					cond:CheckTriggerActive(trigger, true)
					cond:ChangeColor({ 1, 1, 1, 1 })
					cond:ChangeDesaturate(false)
					cond:ChangeGlowVisibility(glow, true)
				end,
			},
			{ spellId = 417045 },
			{ spellId = 417157 },
		},
		secondary = {
			{ spellId = 6795 }, -- Growl
			{ spellId = 740 }, -- Tranquility
			{ spellId = 1850 }, -- Dash
			{ spellId = 20549 }, -- War Stomp
			{ spellId = 20739 }, -- Rebirth
		},
	},
}
