local _, ns = ...

ns.trackers.helpers.createSpellProcIcon = function(spellId, procIds, size)
	return function(t)
		t.needs:SpellKnown(spellId, true)

		local icon = t.display:Icon(size or 64)
		icon:Cooldown()
		icon:Color({ 1, 1, 1, 0.75 })
		icon:Desaturate(true)

		local auraIcon = t.display:AuraIcon(size or 64)
		auraIcon:Cooldown({ reverse = true })

		local border = t.display:Border()
		border:Color({ 0, 0, 0 })

		local progress = t.display:AuraProgressText()
		progress:Point('BOTTOM', 0, -2)

		local spell = t.sources:Spell(spellId, {
			durations = { icon, progress },
			icon = icon,
		})
		local aura = t.sources:Aura('player', 'buff', procIds, {
			elements = { auraIcon, progress },
			ownOnly = true,
		})

		local effect = t.effects:Add()
		effect:CheckOnCooldown(spell, true)
		effect:ChangeColor(icon, { 1, 1, 1, 0.75 })
		effect:ChangeDesaturate(icon, true)

		local effect = t.effects:Add()
		effect:CheckInRange(spell, false)
		effect:ChangeColor(border, { 1, 0, 0 })
	end
end
