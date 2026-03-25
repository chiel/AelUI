local _, ns = ...

ns.storage = {}

local bindShorthands = {
	[1] = 'bop',
	[2] = 'boe',
	[3] = 'bou',
	[4] = 'quest',
}

local bindGlobals = {
	[1] = ITEM_BIND_ON_PICKUP,
	[2] = ITEM_BIND_ON_EQUIP,
	[3] = ITEM_BIND_ON_USE,
	[4] = ITEM_BIND_QUEST,
}

ns.storage.getItemData = function(containerInfo)
	local itemName, _, _, _, _, itemType, itemSubType, _, _, _, _, _, _, bindType = GetItemInfo(containerInfo.hyperlink or '')

	local tags = {}
	local function add(s) tags[#tags + 1] = s:lower() end

	if itemName then add(itemName) end
	if itemType then add(itemType) end
	if itemSubType then add(itemSubType) end

	if bindGlobals[bindType] then add(bindGlobals[bindType]) end
	if bindShorthands[bindType] then add(bindShorthands[bindType]) end

	local quality = containerInfo.quality
	if quality then
		local qname = _G['ITEM_QUALITY' .. quality .. '_DESC']
		if qname then add(qname) end
	end

	return {
		hasItem = true,
		icon = containerInfo.iconFileID,
		count = containerInfo.stackCount,
		quality = quality,
		isLocked = containerInfo.isLocked,
		hyperlink = containerInfo.hyperlink,
		bindType = bindType,
		tags = tags,
	}
end
