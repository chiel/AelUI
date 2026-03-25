local _, ns = ...

local m = ns.media

local SLOT_SIZE = 54
local SLOT_SPACING = 4
local COLUMNS = 8
local BAG_SPACING = 16
local PADDING = 10

local inv = ns.storage.inventory

local container = nil
local bagFrames = {}

local buildBag = ns.storage.bag.build

local function layoutContainer()
	local headerHeight = 32
	local y = -PADDING - headerHeight
	local totalHeight = PADDING + headerHeight

	for _, bagID in ipairs(inv.bagIds) do
		local bagFrame = bagFrames[bagID]
		if bagFrame and #bagFrame.slots > 0 then
			bagFrame:ClearAllPoints()
			bagFrame:SetPoint('TOPLEFT', container, 'TOPLEFT', PADDING, y)
			y = y - bagFrame:GetHeight() - BAG_SPACING
			totalHeight = totalHeight + bagFrame:GetHeight() + BAG_SPACING
		end
	end

	totalHeight = totalHeight - BAG_SPACING + PADDING
	local totalWidth = PADDING * 2 + COLUMNS * (SLOT_SIZE + SLOT_SPACING) - SLOT_SPACING
	container:SetSize(totalWidth, totalHeight)
end

local function getAllSlots()
	local slots = {}
	for _, bagID in ipairs(inv.bagIds) do
		local bagFrame = bagFrames[bagID]
		if bagFrame then
			for _, slot in ipairs(bagFrame.slots) do
				slots[#slots + 1] = slot
			end
		end
	end
	return slots
end

local function applyItems(items)
	for _, bagID in ipairs(inv.bagIds) do
		local bagFrame = bagFrames[bagID]
		if bagFrame then
			local bagItems = items[bagID] or {}
			for slotID, slot in ipairs(bagFrame.slots) do
				slot:SetItem(bagItems[slotID])
			end
		end
	end
	ns.storage.search.applyFilter(getAllSlots(), ns.storage.search.filterQuery)
end

local function buildContainer()
	if container ~= nil then return end

	container = CreateFrame('Frame', 'AelUIInventory', AelUIParent, 'BackdropTemplate')
	container:SetFrameStrata('HIGH')
	container:SetFrameLevel(10)
	container:EnableMouse(true)
	container:Hide()

	container:SetBackdrop({ edgeFile = m.borders.default.file, edgeSize = 1 })
	container:SetBackdropBorderColor(0, 0, 0, 1)

	local bg = container:CreateTexture(nil, 'BORDER')
	bg:SetColorTexture(0.08, 0.08, 0.08)
	bg:SetPoint('TOPLEFT', 1, -1)
	bg:SetPoint('BOTTOMRIGHT', -1, 1)

	container:SetPoint('BOTTOMRIGHT', AelUIParent, 'BOTTOMRIGHT', -16, 16)

	ns.storage.search.subscribe(function(q)
		if container:IsShown() then
			ns.storage.search.applyFilter(getAllSlots(), q)
		end
	end)

	local goldDisplay = ns.storage.gold.create(container)
	goldDisplay:SetPoint('TOPRIGHT', container, 'TOPRIGHT', -PADDING - 10, -PADDING)

	local searchBox = ns.storage.search.create(container)
	searchBox:SetPoint('TOPLEFT', container, 'TOPLEFT', PADDING, -PADDING)
	searchBox:SetPoint('RIGHT', goldDisplay, 'LEFT', -8, 0)
end

inv.isBuilt = function() return container ~= nil end

inv.isOpen = function() return container ~= nil and container:IsShown() end

inv.toggle = function(bags, items)
	if inv.isOpen() then
		container:Hide()
	else
		inv.open(bags, items)
	end
end

inv.open = function(bags, items)
	if inv.isOpen() then return end

	buildContainer()
	for _, bagID in ipairs(inv.bagIds) do
		local numSlots = bags[bagID] and bags[bagID].numSlots or 0
		buildBag(container, bagFrames, bagID, numSlots, { columns = COLUMNS, slotSize = SLOT_SIZE, spacing = SLOT_SPACING })
	end
	layoutContainer()
	applyItems(items)
	container:Show()
end

inv.updateBag = function(bagID, numSlots, items)
	buildBag(container, bagFrames, bagID, numSlots, { columns = COLUMNS, slotSize = SLOT_SIZE, spacing = SLOT_SPACING })
	layoutContainer()
	local bagItems = items or {}
	for slotID = 1, numSlots do
		bagFrames[bagID].slots[slotID]:SetItem(bagItems[slotID])
	end
	ns.storage.search.applyFilter(getAllSlots(), ns.storage.search.filterQuery)
end

inv.updateItems = function(items) applyItems(items) end

inv.updateSlot = function(bagID, slotID, item)
	local bagFrame = bagFrames[bagID]
	if not bagFrame then return end
	local slot = bagFrame.slots[slotID]
	if not slot then return end
	slot:SetItem(item)
end
