local ns = select(2, ...)

local m = ns.media

ns.weakauras.createItemIconBuilder = function(itemId, custom)
	return function(idPrefix, config)
		local itemName = C_Item.GetItemNameByID(itemId)

		local id = idPrefix .. ' - ' .. itemName
		local icon = ns.weakauras.createIcon(id, config)

		local trigger = icon.triggers:AddItemCooldown(itemId, {
			show = 'always',
		})

		local cond = icon.conditions:Add()
		cond:CheckOnCooldown(trigger, true)
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
