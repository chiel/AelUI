local _, ns = ...

local chardata = ns.chardata

-- itemID -> { { char = key, class = class, bags = count, bank = count }, ... }
local cache = {}

local function addCharToCache(charKey, data)
	if not data or not data.storage then return end

	local function addBags(source, field)
		if not source then return end
		for _, bag in pairs(source) do
			for _, item in pairs(bag) do
				if item and item.itemID then
					if not cache[item.itemID] then cache[item.itemID] = {} end
					local entries = cache[item.itemID]
					-- Find or create entry for this char
					local entry
					for _, e in ipairs(entries) do
						if e.char == charKey then entry = e; break end
					end
					if not entry then
						entry = { char = charKey, class = data.class, bags = 0, bank = 0 }
						entries[#entries + 1] = entry
					end
					entry[field] = entry[field] + (item.count or 1)
				end
			end
		end
	end

	addBags(data.storage.inventory, 'bags')
	addBags(data.storage.bank, 'bank')
end

local function removeCharFromCache(charKey)
	for itemID, entries in pairs(cache) do
		for i = #entries, 1, -1 do
			if entries[i].char == charKey then
				table.remove(entries, i)
			end
		end
		if #entries == 0 then cache[itemID] = nil end
	end
end

chardata.buildCache = function()
	wipe(cache)
	local characters = ns.db.global.characters
	if not characters then return end
	for charKey, data in pairs(characters) do
		addCharToCache(charKey, data)
	end
end

chardata.rebuildCurrentChar = function()
	removeCharFromCache(chardata.charKey)
	local char = ns.db.global.characters[chardata.charKey]
	if char then addCharToCache(chardata.charKey, char) end
end

chardata.lookup = function(itemID)
	return cache[itemID]
end
