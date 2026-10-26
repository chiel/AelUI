local _, ns = ...

ns.trackers.helpers.createAuraIcon = function(unit, auraType, spellIds, size)
	spellIds = type(spellIds) == 'table' and spellIds or { spellIds }

	return function(t)
		t.needs:SpellKnown(spellIds[1], true)

		local icon = t.display:Icon(size or 64)
		icon:Color({ 1, 1, 1, 0.75 })
		icon:Desaturate(true)

		local auraIcon = t.display:AuraIcon(size or 64)
		auraIcon:Cooldown({ reverse = true })

		local border = t.display:Border()
		border:Color({ 0, 0, 0 })

		local progress = t.display:AuraText()
		progress:Point('BOTTOM', 0, -2)

		local spell = t.sources:Spell(spellIds[1], { icon = icon })
		local aura = t.sources:Aura(unit, auraType, spellIds, {
			elements = { auraIcon, progress },
			ownOnly = true,
		})

		local effect = t.effects:Add()
		effect:CheckInRange(spell, false)
		effect:ChangeColor(border, { 1, 0, 0, 1 })
	end
end
