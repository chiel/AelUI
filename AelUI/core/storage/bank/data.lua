local _, ns = ...

local bank = ns.storage.bank

local function fetchSlot(bagID, slotID)
	local info = C_Container.GetContainerItemInfo(bagID, slotID)
	if not info then return nil end

	local data = ns.storage.getItemData(info)

	local start, duration, enable = C_Container.GetContainerItemCooldown(bagID, slotID)
	data.cdStart = start or 0
	data.cdDuration = duration or 0
	data.cdEnable = enable or 0

	local questInfo = C_Container.GetContainerItemQuestInfo(bagID, slotID)
	if questInfo then
		data.isQuestItem = questInfo.isQuestItem or questInfo.isActive
		data.startsQuest = questInfo.questID and not questInfo.isActive
	end

	return data
end

local function fetchBag(bagID, numSlots)
	local items = {}
	for slotID = 1, numSlots do
		items[slotID] = fetchSlot(bagID, slotID)
	end
	return items
end

local function fetchAll(bags)
	local items = {}
	for _, bagID in ipairs(bank.bagIds) do
		local numSlots = bags[bagID] and bags[bagID].numSlots or 0
		items[bagID] = fetchBag(bagID, numSlots)
	end
	return items
end

bank.data = {
	fetchAll = fetchAll,
	fetchBag = fetchBag,
	fetchSlot = fetchSlot,
}
