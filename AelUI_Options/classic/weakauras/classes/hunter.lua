local addon = select(2, ...)

addon.classic.weakauras.classes.hunter = {
	name = 'Hunter',
	icon = 626000,
	class = 'HUNTER',

	groups = {
		primary = {
			{ -- Auto Shot
				spellId = 75,
				custom = function(aura)
					aura.display:SetColor({ 1, 1, 1, 0.5 })
					aura.display:SetDesaturate(true)

					local glow = aura.display:AddGlow('pixel', {
						color = { 1, 1, 1, 1 },
					})
					aura.display:MoveToBackground(glow)

					local trigger = aura.triggers:AddCustomStatus({
						events = 'START_AUTOREPEAT_SPELL STOP_AUTOREPEAT_SPELL',
						custom = 'function() return IsAutoRepeatSpell(75) end',
					})
					aura.triggers:SetDisjunctive('any')

					local cond = aura.conditions:Add()
					cond:CheckTriggerActive(trigger, true)
					cond:ChangeColor({ 1, 1, 1, 1 })
					cond:ChangeDesaturate(false)
					cond:ChangeGlowVisibility(glow, true)
				end,
			},
			{ spellId = 3045 }, -- Rapid Fire
			{ spellId = 1510 }, -- Volley
			{ spellId = 19574 }, -- Bestial Wrath
			{ spellId = 409379 }, -- Kill Command
			{ spellId = 409552 }, -- Explosive Shot
			{ spellId = 2643 }, -- Multi-Shot
			{ spellId = 14282 }, -- Arcane Shot
			{ spellId = 415320 }, -- Flanking Strike
			{ spellId = 14261 }, -- Raptor Strike
			{ spellId = 409532 }, -- Explosive Trap
		},
		secondary = {
			{ spellId = 1499 }, -- Freezing Trap
			{ spellId = 5116 }, -- Concussive Shot
			{ spellId = 19577 }, -- Intimidation
			{ spellId = 5384 }, -- Feign Death
			{ spellId = 14272 }, -- Disengage
			{ spellId = 15630 }, -- Distracting Shot
			{ spellId = 14326 }, -- Scare Beast
			{ spellId = 1543 }, -- Flare
		},
		tracking = {
			{ debuffId = 14324 }, -- Hunter's Mark
			{ debuffId = 13550 }, -- Serpent Sting
		},
	},
}
