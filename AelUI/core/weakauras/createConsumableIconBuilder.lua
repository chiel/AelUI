local ns = select(2, ...)

local m = ns.media

ns.weakauras.createConsumableIconBuilder = function(itemId, custom)
	return function(idPrefix, config)
		local itemName = C_Item.GetItemNameByID(itemId)

		local id = idPrefix .. ' - ' .. itemName
		local icon = ns.weakauras.createIcon(id, config)

		local glow = icon.display:AddGlow('proc', { startAnimation = true })
		icon.display:Move(glow, 3)

		icon.display:AddText('%2.s', {
			font = m.fonts.bold.name,
			size = 12,
			justify = 'RIGHT',
			anchor = {
				from = 'TOPRIGHT',
				to = 'TOPRIGHT',
				y = -1,
			},
		})

		local itemCooldown = icon.triggers:AddItemCooldown(itemId, {
			show = 'always',
		})

		local itemCount = icon.triggers:AddItemCount(itemId)

		local cond = icon.conditions:Add()
		cond:CheckOnCooldown(itemCooldown, true)
		cond:ChangeColor({ 1, 1, 1, 0.75 })
		cond:ChangeDesaturate(true)

		local cond = icon.conditions:Add()
		cond:CheckStacks(itemCount, '==', 0)
		cond:ChangeColor({ 1, 1, 1, 0.75 })
		cond:ChangeDesaturate(true)
		cond:ChangeGlowVisibility(glow, true)

		if custom ~= nil then
			local override = custom(icon, data)
			if override ~= nil then
				icon = override
			end
		end

		return icon
	end
end
