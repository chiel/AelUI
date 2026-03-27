local _, ns = ...

local rolls = {} -- rollID -> roll state
ns.lootrolls.rolls = rolls

ns.lootrolls.onStartRoll = function(rollID, rollTime)
	local texture, name, count, quality, bindOnPickUp, canNeed, canGreed = GetLootRollItemInfo(rollID)
	local itemLink = GetLootRollItemLink(rollID)

	rolls[rollID] = {
		rollID = rollID,
		texture = texture,
		name = name,
		count = count,
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

local function logRoll(roll)
	if not ns.db then
		return
	end
	if #roll.players <= 1 then
		return
	end

	local log = ns.db.char.lootLog
	table.insert(log, 1, {
		itemName = roll.name,
		itemLink = roll.itemLink,
		texture = roll.texture,
		quality = roll.quality,
		timestamp = time(),
		rolls = roll.players,
	})

	-- Trim to 10 entries
	while #log > 10 do
		table.remove(log)
	end
end

ns.lootrolls.onRollComplete = function()
	for i = 1, C_LootHistory.GetNumItems() do
		local rollID, _, _, isDone = C_LootHistory.GetItem(i)
		local roll = rolls[rollID]
		if roll and isDone then
			logRoll(roll)
			rolls[rollID] = nil
		end
	end
end
