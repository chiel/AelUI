local _, ns = ...

local s = ns.fishing

local MAINHAND_SLOT = 16

-- Known fishing lures (TBC Classic): { itemID, bonus }
local LURES = {
	{ 6529,  25  }, -- Shiny Bauble
	{ 6530,  50  }, -- Nightcrawlers
	{ 6533,  50  }, -- Aquadynamic Fish Lens
	{ 6532,  75  }, -- Bright Baubles
	{ 7307,  75  }, -- Flesh Eating Worm
	{ 6811,  100 }, -- Aquadynamic Fish Attractor
	{ 34861, 100 }, -- Sharpened Fish Hook
}

local state = {
	hasPole = false,
	hasEnchant = false,
	lures = {},
}

s.state = state

s.updateEquipment = function()
	local itemID = GetInventoryItemID('player', MAINHAND_SLOT)
	if itemID then
		local _, _, _, _, _, _, subclassID = GetItemInfoInstant(itemID)
		state.hasPole = subclassID == 20
	else
		state.hasPole = false
	end
	state.hasEnchant = GetWeaponEnchantInfo() or false
end

s.updateLures = function()
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
	table.sort(lures, function(a, b) return a.bonus > b.bonus end)
	state.lures = lures
end

s.updateEnchant = function()
	local hasEnchant = GetWeaponEnchantInfo() or false
	if hasEnchant == state.hasEnchant then return false end
	state.hasEnchant = hasEnchant
	return true
end
