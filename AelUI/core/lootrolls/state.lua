local _, ns = ...

local rolls = {} -- rollID -> roll state
ns.lootrolls.rolls = rolls

ns.lootrolls.onStartRoll = function(rollID, rollTime)
	local texture, name, _, quality, bindOnPickUp, canNeed, canGreed = GetLootRollItemInfo(rollID)
	local itemLink = GetLootRollItemLink(rollID)

	rolls[rollID] = {
		rollID = rollID,
		texture = texture,
		name = name,
		itemLink = itemLink,
		quality = quality,
		bindOnPickUp = bindOnPickUp,
		canNeed = canNeed,
		canGreed = canGreed,
		duration = rollTime / 1000,
		startTime = GetTime(),
		players = {},
		dismissed = false,
	}
end

ns.lootrolls.onCancelRoll = function(rollID)
	local roll = rolls[rollID]
	if roll then
		roll.dismissed = true
	end
end

ns.lootrolls.onRollChanged = function(itemIdx, playerIdx)
	local pName, pClass, rollType, rollValue, isWinner = C_LootHistory.GetPlayerInfo(itemIdx, playerIdx)
	if not rollType then
		return
	end

	local rollID = C_LootHistory.GetItem(itemIdx)
	local roll = rolls[rollID]
	if not roll then
		return
	end

	for _, p in ipairs(roll.players) do
		if p.name == pName then
			p.class = pClass
			p.rollType = rollType
			p.roll = rollValue
			p.isWinner = isWinner
			return
		end
	end

	table.insert(roll.players, {
		name = pName,
		class = pClass,
		rollType = rollType,
		roll = rollValue,
		isWinner = isWinner,
	})
end

ns.lootrolls.onRollComplete = function()
	for i = 1, C_LootHistory.GetNumItems() do
		local rollID, _, _, isDone = C_LootHistory.GetItem(i)
		local roll = rolls[rollID]
		if roll and isDone then
			rolls[rollID] = nil
		end
	end
end
