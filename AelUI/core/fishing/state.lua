local _, ns = ...

local f = ns.fishing

local LURES = {
	{ 6529, 25 }, -- Shiny Bauble
	{ 6530, 50 }, -- Nightcrawlers
	{ 6532, 75 }, -- Bright Baubles
	{ 6533, 100 }, -- Aquadynamic Fish Attractor
}

local state = {
	hasPole = false,
	hasEnchant = false,
	lures = {},
}

f.state = state

f.updateEquipment = function()
	local itemID = GetInventoryItemID('player', f.mainhandSlot)
	if itemID then
		local subclassID = select(7, GetItemInfoInstant(itemID))
		state.hasPole = subclassID == 20
	else
		state.hasPole = false
	end

	state.hasEnchant = GetWeaponEnchantInfo() or false
end

f.updateLures = function()
	local lures = {}

	for _, lure in ipairs(LURES) do
		local id, bonus = lure[1], lure[2]
		local count = GetItemCount(id)
		if count > 0 then
			local name = GetItemInfo(id)
			local icon = GetItemIcon(id)
			if name then
				table.insert(lures, {
					id = id,
					name = name,
					icon = icon,
					bonus = bonus,
					count = count,
				})
			end
		end
	end

	table.sort(lures, function(a, b)
		return a.bonus > b.bonus
	end)

	state.lures = lures
end

f.updateEnchant = function()
	if not f.state.hasPole then
		return false
	end

	local hasEnchant = GetWeaponEnchantInfo() or false
	if hasEnchant == state.hasEnchant then
		return false
	end

	state.hasEnchant = hasEnchant
	return true
end
