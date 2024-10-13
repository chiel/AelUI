local _, ns = ...

local m = ns.media

ns.weakauras.auraIcon = function(unit, auraType, auraId, custom)
	return function(idPrefix, config)
		local spellInfo = C_Spell.GetSpellInfo(auraId)

		local id = idPrefix .. ' - ' .. spellInfo.name
		local icon = ns.weakauras.icon(id, config)
		icon.display:SetCooldown({ inverse = false })
		ns.weakauras.addProgressText(icon)
		ns.weakauras.addStacksText(icon)

		local trigger = icon.triggers:AddAura(unit, auraType, {
			show = 'always',
			exactSpellIds = { auraId },
		})

		if custom ~= nil then
			local override = custom(icon, data)
			if override ~= nil then
				icon = override
			end
		end

		return icon
	end
end
