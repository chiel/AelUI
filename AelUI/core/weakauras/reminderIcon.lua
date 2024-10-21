local _, ns = ...

local wa = ns.weakauras

ns.weakauras.reminderIcon = function(auraId)
	return function(idPrefix, config)
		local spellInfo = C_Spell.GetSpellInfo(auraId)
		local id = idPrefix .. ' - ' .. spellInfo.name
		local icon = wa.icon(id, config)
		icon.display:SetCooldown({ inverse = false })
		local trigger = icon.triggers:AddAura('player', 'buff', {
			exactSpellIds = { auraId },
			show = 'onMissing',
		})

		icon.animations:Start('preset', 'fade')
		icon.animations:Main('preset', 'flash')
		icon.animations:Finish('preset', 'fade')

		if custom ~= nil then
			local override = custom(icon, data)
			if override ~= nil then
				icon = override
			end
		end

		return icon
	end
end
