local _, ns = ...

ns.trackers.helpers.createSpellIcon = function(spellId, size)
	return function(t)
		t.needs:SpellKnown(spellId, true)

		local icon = t.display:Icon(size or 64)
		icon:Cooldown()

		local border = t.display:Border()
		border:Color({ 0, 0, 0 })

		local progress = t.display:Text()
		progress:Point('BOTTOM', 0, -2)

		local cd = t.sources:Spell(spellId, {
			durations = { icon, progress },
			icon = icon,
		})

		local effect = t.effects:Add()
		effect:CheckOnCooldown(cd, true)
		effect:ChangeColor(icon, { 1, 1, 1, 0.75 })
		effect:ChangeDesaturate(icon, true)
	end
end
