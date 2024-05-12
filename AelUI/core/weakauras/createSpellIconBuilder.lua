local ns = select(2, ...)

local m = ns.media

ns.weakauras.createSpellIconBuilder = function(spellId, custom)
	return function(idPrefix, config)
		local spellName = GetSpellInfo(spellId)

		-- if debuffId ~= nil then
		-- 	spellName = GetSpellInfo(debuffId)
		-- end

		local id = idPrefix .. ' - ' .. spellName
		local icon = ns.weakauras.createIcon(id, config)

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
