local _, ns = ...

local wa = ns.weakauras
local h = wa.helpers

wa.creators.auraIcon = function(unit, auraType, spellIds)
	if type(spellIds) ~= 'table' then
		spellIds = { spellIds }
	end

	return function(idSuffix, config)
		local spellInfo = C_Spell.GetSpellInfo(spellIds[1])
		local id = spellInfo.name .. idSuffix

		local icon = h.icon(id, config)
		icon.display:SetCooldown({ inverse = false, text = false })
		icon.display:SetColor({ 1, 1, 1, 0.75 })
		icon.display:SetDesaturate(true)
		icon.display:SetIcon(spellInfo.iconID)
		h.addProgressText(icon)

		icon.triggers:SetActivateOn('any')
		local aura = icon.triggers:AddAura(unit, auraType, {
			ownOnly = true,
			show = 'onActive',
			spellIds = spellIds,
		})
		icon.triggers:AddUnitConditions({ alwaysActive = true })

		local cond = icon.conditions:Add()
		cond:CheckActive(aura, true)
		cond:ChangeColor({ 1, 1, 1, 1 })
		cond:ChangeDesaturate(false)

		return icon
	end
end
