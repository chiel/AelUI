local addon = select(2, ...)

addon.classic.weakauras.classes.shaman = {
	name = 'Shaman',
	icon = 626006,
	class = 'SHAMAN',

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
			{ spellId = 425339 }, -- Molten Blast
			{ spellId = 8050 }, -- Flame Shock
			{ spellId = 408681 }, -- Earth Shock
			{ spellId = 8056 }, -- Frost Shock
			{ spellId = 1535 }, -- Fire Nova Totem
		},
		secondary = {
			{ spellId = 2484 }, -- Earthbind Totem
			{ spellId = 6390 }, -- Stoneclaw Totem
			{ spellId = 20549 }, -- War Stomp
		},
	},
}
