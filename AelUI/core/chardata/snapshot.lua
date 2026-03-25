local _, ns = ...

local chardata = ns.chardata

local INV_BAG_IDS = { 0, 1, 2, 3, 4 }
local BANK_BAG_IDS = { -1, 5, 6, 7, 8, 9, 10, 11 }

local function getSlotSummary(bagID, slotID)
	local info = C_Container.GetContainerItemInfo(bagID, slotID)
	if not info then return nil end

	local itemID = info.hyperlink and tonumber(info.hyperlink:match('item:(%d+)'))
	if not itemID then return nil end

	return {
		itemID = itemID,
		count = info.stackCount,
		icon = info.iconFileID,
		quality = info.quality,
		hyperlink = info.hyperlink,
	}
end

local function snapshotBags(bagIds)
	local result = {}
	for _, bagID in ipairs(bagIds) do
		local numSlots = C_Container.GetContainerNumSlots(bagID)
		if numSlots > 0 then
			local bag = {}
			for slotID = 1, numSlots do
				bag[slotID] = getSlotSummary(bagID, slotID)
			end
			result[bagID] = bag
		end
	end
	return result
end

local function getCharData()
	return ns.db.global.characters[chardata.charKey]
end

-- Inventory: always queryable
local invTimer = nil

local function snapshotInventory()
	invTimer = nil
	local char = getCharData()
	if not char then return end
	if not char.storage then char.storage = {} end
	char.storage.inventory = snapshotBags(INV_BAG_IDS)
	chardata.rebuildCurrentChar()
end

local function debounceInventory()
	if not invTimer then
		invTimer = C_Timer.NewTimer(0.5, snapshotInventory)
	end
end

-- Bank: only queryable while open
local bankOpen = false

local function snapshotBank()
	if not bankOpen then return end
	local char = getCharData()
	if not char then return end
	if not char.storage then char.storage = {} end
	char.storage.bank = snapshotBags(BANK_BAG_IDS)
	chardata.rebuildCurrentChar()
end

-- Events
local handler = CreateFrame('Frame')
handler:RegisterEvent('BAG_UPDATE_DELAYED')
handler:RegisterEvent('BANKFRAME_OPENED')
handler:RegisterEvent('BANKFRAME_CLOSED')
handler:RegisterEvent('PLAYERBANKSLOTS_CHANGED')
handler:RegisterEvent('PLAYERBANKBAGSLOTS_CHANGED')
handler:RegisterEvent('PLAYER_MONEY')
handler:SetScript('OnEvent', function(_, event)
	if event == 'BAG_UPDATE_DELAYED' then
		debounceInventory()
		if bankOpen then snapshotBank() end
	elseif event == 'BANKFRAME_OPENED' then
		bankOpen = true
		snapshotBank()
	elseif event == 'BANKFRAME_CLOSED' then
		snapshotBank()
		bankOpen = false
	elseif event == 'PLAYERBANKSLOTS_CHANGED' or event == 'PLAYERBANKBAGSLOTS_CHANGED' then
		snapshotBank()
	elseif event == 'PLAYER_MONEY' then
		local char = getCharData()
		if char then char.money = GetMoney() end
	end
end)
