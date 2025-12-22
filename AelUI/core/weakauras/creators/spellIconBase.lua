local _, ns = ...

local wa = ns.weakauras
local h = wa.helpers

wa.creators.spellIconBase = function(spellId)
	return function(idSuffix, config)
		local spellInfo = C_Spell.GetSpellInfo(spellId)
		local id = spellInfo.name .. idSuffix

		local icon = h.icon(id, config)
		icon.display:SetCooldown({ inverse = true, text = false })
		local spell = icon.triggers:AddSpellCooldown(spellId, { show = 'always' })

		local cond = icon.conditions:Add()
		cond:CheckOnCooldown(spell, true)
		cond:ChangeColor({ 1, 1, 1, 0.75 })
		cond:ChangeDesaturate(true)

		return icon
	end
end
