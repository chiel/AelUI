local _, ns = ...

local wa = ns.weakauras

ns.weakauras.reminderIcon = function(auraIds)
	return function(idPrefix, config)
		if type(auraIds) ~= 'table' then
			auraIds = { auraIds }
		end

		local spellInfo = C_Spell.GetSpellInfo(auraIds[1])
		local id = idPrefix .. ' - ' .. spellInfo.name
		local icon = wa.icon(id, config)
		icon.display:SetCooldown({ inverse = false })
		local trigger = icon.triggers:AddAura('player', 'buff', {
			exactSpellIds = auraIds,
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
