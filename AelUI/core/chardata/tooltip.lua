local _, ns = ...

local chardata = ns.chardata

local BAG_ICON = '|TInterface\\Buttons\\Button-Backpack-Up:0|t'
local BANK_ICON = '|TInterface\\Icons\\INV_Box_01:0|t'

local function getItemIDFromTooltip(tooltip)
	local _, link = tooltip:GetItem()
	if not link then return nil end
	return tonumber(link:match('item:(%d+)'))
end

local function formatCounts(bags, bank)
	local parts = {}
	if bags > 0 then parts[#parts + 1] = BAG_ICON .. ' ' .. bags end
	if bank > 0 then parts[#parts + 1] = BANK_ICON .. ' ' .. bank end
	return table.concat(parts, '  ')
end

local function onTooltipSetItem(tooltip)
	local itemID = getItemIDFromTooltip(tooltip)
	if not itemID then return end

	local entries = chardata.lookup(itemID)
	if not entries then return end

	table.sort(entries, function(a, b)
		local nameA = ns.db.global.characters[a.char]
		local nameB = ns.db.global.characters[b.char]
		return (nameA and nameA.name or a.char) < (nameB and nameB.name or b.char)
	end)

	tooltip:AddLine(' ')

	for _, entry in ipairs(entries) do
		local name = ns.db.global.characters[entry.char]
		local displayName = name and name.name or entry.char
		if name and name.realm ~= chardata.charRealm then
			displayName = displayName .. ' - ' .. name.realm
		end

		local classColor = RAID_CLASS_COLORS[entry.class]
		local r, g, b = 1, 1, 1
		if classColor then r, g, b = classColor.r, classColor.g, classColor.b end

		local total = entry.bags + entry.bank
		local right
		if entry.bags > 0 and entry.bank > 0 then
			right = total .. '  (' .. formatCounts(entry.bags, entry.bank) .. ')'
		else
			right = formatCounts(entry.bags, entry.bank)
		end

		tooltip:AddDoubleLine(displayName, right, r, g, b, 1, 1, 1)
	end

	tooltip:Show()
end

-- Build cache on init, hook tooltip
ns.OnInitialise(function()
	chardata.buildCache()
	GameTooltip:HookScript('OnTooltipSetItem', onTooltipSetItem)
	ItemRefTooltip:HookScript('OnTooltipSetItem', onTooltipSetItem)
end)
