local _, ns = ...

local m = ns.media

ns.weakauras.spellIcon = function(spellId, custom)
	return function(idPrefix, config)
		local spellName = GetSpellInfo(spellId)

		local id = idPrefix .. ' - ' .. spellName
		local icon = ns.weakauras.icon(id, config)
		ns.weakauras.addProgressText(icon)
		ns.weakauras.addStacksText(icon)

		local trigger = icon.triggers:AddSpellCooldown(spellId, {
			show = 'always',
		})

		local cond = icon.conditions:Add()
		cond:CheckCharges(trigger, '==', 0)
		cond:ChangeColor({ 1, 1, 1, 0.75 })
		cond:ChangeDesaturate(true)

		local cond = icon.conditions:Add()
		cond:CheckSpellInRange(trigger, false)
		cond:ChangeColor({ 1, 0, 0, 0.75 })
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
