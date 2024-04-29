local addon = select(2, ...)

addon.classic.weakauras.classes.priest = {
	name = 'Priest',
	icon = 626004,
	class = 'PRIEST',

	groups = {
		primary = {
			{ -- Shoot
				spellId = 5019,
				custom = function(aura)
					aura.display:SetColor({ 1, 1, 1, 0.5 })
					aura.display:SetDesaturate(true)

					local glow = aura.display:AddGlow('pixel', {
						color = { 1, 1, 1, 1 },
						-- lines = 4,
						-- length = 20,
					})
					aura.display:MoveToBackground(glow)

					local trigger = aura.triggers:AddCustomStatus({
						events = 'START_AUTOREPEAT_SPELL STOP_AUTOREPEAT_SPELL',
						custom = 'function() return IsAutoRepeatSpell(5019) end',
					})
					aura.triggers:SetDisjunctive('any')

					local cond = aura.conditions:Add()
					cond:CheckTriggerActive(trigger, true)
					cond:ChangeColor({ 1, 1, 1, 1 })
					cond:ChangeDesaturate(false)
					cond:ChangeGlowVisibility(glow, true)
				end,
			},
			{ spellId = 402799 }, -- Homunculi
			{ spellId = 402174 }, -- Penance
			{ spellId = 401859 }, -- Prayer of Mending
			{ spellId = 8103 }, -- Mind Blast
			{ spellId = 3747 }, -- Power Word: Shield
			{ spellId = 9578 }, -- Fade
			{ spellId = 8122 }, -- Psychic Scream
		},
	},
}
