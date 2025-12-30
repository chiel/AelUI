local _, ns = ...

local wa = ns.weakauras
local h = wa.helpers

wa.creators.auraIcon = function(unit, auraType, auraId)
	return function(idSuffix, config)
		local spellInfo = C_Spell.GetSpellInfo(auraId)
		local id = spellInfo.name .. idSuffix

		local icon = h.icon(id, config)
		icon.display:SetCooldown({ inverse = false, text = false })

		icon.triggers:AddAura(unit, auraType, {
			ownOnly = true,
			show = 'always',
			spellIds = { auraId },
		})

		return icon
	end
end
