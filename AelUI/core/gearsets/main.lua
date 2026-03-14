local _, ns = ...

local EQUIPMENT_SLOTS = {
	INVSLOT_HEAD,
	INVSLOT_NECK,
	INVSLOT_SHOULDER,
	INVSLOT_BACK,
	INVSLOT_CHEST,
	INVSLOT_WRIST,
	INVSLOT_HAND,
	INVSLOT_WAIST,
	INVSLOT_LEGS,
	INVSLOT_FEET,
	INVSLOT_FINGER1,
	INVSLOT_FINGER2,
	INVSLOT_TRINKET1,
	INVSLOT_TRINKET2,
	INVSLOT_MAINHAND,
	INVSLOT_OFFHAND,
	INVSLOT_RANGED,
	INVSLOT_TABARD,
	INVSLOT_BODY, -- shirt
}

local function saveSet(name)
	local set = {}
	for _, slotID in ipairs(EQUIPMENT_SLOTS) do
		local link = GetInventoryItemLink('player', slotID)
		if link then
			set[slotID] = link
		end
	end
	ns.db.char.gearSets[name] = set
	ns.console:Print(string.format('Gear set "%s" saved.', name))
end

local function equipSet(name)
	local set = ns.db.char.gearSets[name]
	if not set then
		ns.console:Print(string.format('Gear set "%s" not found.', name))
		return
	end

	if InCombatLockdown() then
		ns.console:Print('Cannot swap gear in combat.')
		return
	end

	for slotID, link in pairs(set) do
		local currentLink = GetInventoryItemLink('player', slotID)
		if currentLink ~= link then
			EquipItemByName(link, slotID)
		end
	end
	ns.console:Print(string.format('Equipping gear set "%s".', name))
end

local function deleteSet(name)
	if not ns.db.char.gearSets[name] then
		ns.console:Print(string.format('Gear set "%s" not found.', name))
		return
	end
	ns.db.char.gearSets[name] = nil
	ns.console:Print(string.format('Gear set "%s" deleted.', name))
end

local function listSets()
	local count = 0
	for name in pairs(ns.db.char.gearSets) do
		ns.console:Print('  ' .. name)
		count = count + 1
	end
	if count == 0 then
		ns.console:Print('No gear sets saved.')
	end
end

ns.OnInitialise(function()
	ns.console:RegisterChatCommand('gs', function(input)
		local cmd, name = strsplit(' ', input or '', 2)
		cmd = cmd and cmd:trim():lower() or ''
		name = name and name:trim() or ''

		if cmd == 'save' and name ~= '' then
			saveSet(name)
		elseif cmd == 'equip' and name ~= '' then
			equipSet(name)
		elseif cmd == 'delete' and name ~= '' then
			deleteSet(name)
		elseif cmd == 'list' then
			listSets()
		else
			ns.console:Print('Usage:')
			ns.console:Print('  /gs save <name>  - Save current gear')
			ns.console:Print('  /gs equip <name> - Equip a saved set')
			ns.console:Print('  /gs delete <name> - Delete a saved set')
			ns.console:Print('  /gs list - List saved sets')
		end
	end)
end)
