local ns = select(2, ...)

local m = ns.media

ns.weakauras.createAuraIconBuilder = function(unit, auraType, auraId, custom)
	return function(idPrefix, config)
		local spellName = GetSpellInfo(auraId)

		local id = idPrefix .. ' - ' .. spellName .. ' ' .. auraType
		local icon = ns.weakauras.createIcon(id, config)
		icon.display:SetCooldown({ inverse = false })

		icon.display:AddText('%s', {
			font = m.fonts.bold.name,
			size = 12,
			justify = 'RIGHT',
			anchor = {
				from = 'TOPRIGHT',
				to = 'TOPRIGHT',
				y = -1,
			},
		})

		local trigger = icon.triggers:AddAura(unit, auraType, {
			exactSpellIds = { auraId },
			ownOnly = true,
			show = 'always',
		})

		local cond = icon.conditions:Add()
		cond:CheckAuraFound(trigger, false)
		cond:ChangeColor({ 1, 1, 1, 0.75 })
		cond:ChangeDesaturate(true)

		if custom ~= nil then
			local override = custom(icon, data)
			if override ~= nil then
				icon = override
			end
		end

		return icon
	end
end
