local _, ns = ...

local m = ns.media

local SLOT_SIZE = 54
local SLOT_SPACING = 4
local COLUMNS = 8
local BAG_SPACING = 16
local PADDING = 10

local bank = ns.storage.bank

local container = nil
local bagFrames = {}

local buildBag = ns.storage.bag.build

-- Bank bag bar config
local BANK_BAG_IDS = { 5, 6, 7, 8, 9, 10, 11 }
local BAG_SLOT_SIZE = 40
local BAG_SLOT_SPACING = 4

local bagBar = nil
local bagSlots = {}
local toggleBtn = nil

local layoutContainer -- forward declaration

local function updateBagBar()
	local numPurchased = GetNumBankSlots()
	for i, btn in ipairs(bagSlots) do
		local texture = GetInventoryItemTexture('player', btn.invSlotID)
		if texture then
			btn.icon:SetTexture(texture)
			btn.icon:Show()
			btn.bd:SetBackdropBorderColor(0, 0, 0, 1)
		elseif i <= numPurchased then
			btn.icon:SetTexture([[Interface\PaperDoll\UI-Backpack-EmptySlot]])
			btn.icon:Show()
			btn.bd:SetBackdropBorderColor(0, 0, 0, 1)
		else
			btn.icon:SetTexture([[Interface\PaperDoll\UI-Backpack-EmptySlot]])
			btn.icon:Show()
			btn.bd:SetBackdropBorderColor(0.6, 0.1, 0.1, 1)
		end
	end
end

local function buildBagBar()
	bagBar = CreateFrame('Frame', nil, container)
	bagBar:Hide()

	for i, bagID in ipairs(BANK_BAG_IDS) do
		local invSlotID = C_Container.ContainerIDToInventoryID(bagID)
		local name = 'AelUIBankBagSlot' .. i
		local btn = CreateFrame('ItemButton', name, bagBar)
		btn:SetSize(BAG_SLOT_SIZE, BAG_SLOT_SIZE)
		btn.icon = btn.icon or btn.Icon
		ns.helpers.styleIcon(btn)

		btn.invSlotID = invSlotID
		btn.bagID = bagID
		btn.bagIndex = i

		btn:RegisterForDrag('LeftButton')

		btn:SetScript('OnDragStart', function(self)
			PickupBagFromSlot(self.invSlotID)
		end)

		btn:SetScript('OnClick', function(self)
			if CursorHasItem() then
				PutItemInBag(self.invSlotID)
			end
		end)

		btn:SetScript('OnReceiveDrag', function(self)
			PutItemInBag(self.invSlotID)
		end)

		btn:SetScript('OnEnter', function(self)
			GameTooltip:SetOwner(self, 'ANCHOR_LEFT')
			GameTooltip:SetInventoryItem('player', self.invSlotID)
			GameTooltip:Show()
		end)

		btn:SetScript('OnLeave', GameTooltip_Hide)

		bagSlots[i] = btn
	end

	toggleBtn = CreateFrame('Button', nil, container)
	toggleBtn:SetSize(20, 20)

	local toggleIcon = toggleBtn:CreateTexture(nil, 'ARTWORK')
	toggleIcon:SetAllPoints()
	toggleIcon:SetTexture([[Interface\Buttons\Button-Backpack-Up]])
	toggleIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

	toggleBtn:SetScript('OnClick', function()
		if bagBar:IsShown() then
			bagBar:Hide()
		else
			updateBagBar()
			bagBar:Show()
		end
		layoutContainer()
	end)

	toggleBtn:SetScript('OnEnter', function(self)
		GameTooltip:SetOwner(self, 'ANCHOR_LEFT')
		GameTooltip:SetText('Toggle Bag Slots')
		GameTooltip:Show()
	end)

	toggleBtn:SetScript('OnLeave', GameTooltip_Hide)
end

layoutContainer = function()
	local headerHeight = 20 + PADDING
	if bagBar and bagBar:IsShown() then
		headerHeight = headerHeight + BAG_SLOT_SIZE + PADDING
	end

	if toggleBtn then
		toggleBtn:ClearAllPoints()
		toggleBtn:SetPoint('TOPRIGHT', container, 'TOPRIGHT', -PADDING, -PADDING)
	end

	if bagBar and bagBar:IsShown() then
		bagBar:SetSize(#bagSlots * (BAG_SLOT_SIZE + BAG_SLOT_SPACING) - BAG_SLOT_SPACING, BAG_SLOT_SIZE)
		bagBar:ClearAllPoints()
		bagBar:SetPoint('TOPLEFT', container, 'TOPLEFT', PADDING, -PADDING - 20 - PADDING)

		for i, btn in ipairs(bagSlots) do
			btn:ClearAllPoints()
			btn:SetPoint('LEFT', bagBar, 'LEFT', (i - 1) * (BAG_SLOT_SIZE + BAG_SLOT_SPACING), 0)
		end
	end

	local y = -PADDING - headerHeight
	local totalHeight = PADDING + headerHeight

	for _, bagID in ipairs(bank.bagIds) do
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
	for _, bagID in ipairs(bank.bagIds) do
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
	for _, bagID in ipairs(bank.bagIds) do
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

	container = CreateFrame('Frame', 'AelUIBank', AelUIParent, 'BackdropTemplate')
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

	container:SetPoint('BOTTOMRIGHT', AelUIInventory, 'BOTTOMLEFT', -16, 0)

	ns.storage.search.subscribe(function(q)
		if container:IsShown() then
			ns.storage.search.applyFilter(getAllSlots(), q)
		end
	end)

	buildBagBar()

	container:EnableKeyboard(true)
	container:SetScript('OnKeyDown', function(self, key)
		if key == 'ESCAPE' then
			self:SetPropagateKeyboardInput(false)
			CloseBankFrame()
		else
			self:SetPropagateKeyboardInput(true)
		end
	end)
end

bank.isBuilt = function() return container ~= nil end

bank.isOpen = function() return container ~= nil and container:IsShown() end

bank.open = function(bags, items)
	if bank.isOpen() then return end

	buildContainer()
	for _, bagID in ipairs(bank.bagIds) do
		local numSlots = bags[bagID] and bags[bagID].numSlots or 0
		buildBag(container, bagFrames, bagID, numSlots, { columns = COLUMNS, slotSize = SLOT_SIZE, spacing = SLOT_SPACING })
	end
	layoutContainer()
	applyItems(items)
	updateBagBar()
	container:Show()
end

bank.close = function()
	if not bank.isOpen() then return end
	container:Hide()
end

bank.updateBag = function(bagID, numSlots, items)
	buildBag(container, bagFrames, bagID, numSlots, { columns = COLUMNS, slotSize = SLOT_SIZE, spacing = SLOT_SPACING })
	layoutContainer()
	local bagItems = items or {}
	for slotID = 1, numSlots do
		bagFrames[bagID].slots[slotID]:SetItem(bagItems[slotID])
	end
	ns.storage.search.applyFilter(getAllSlots(), ns.storage.search.filterQuery)
end

bank.updateItems = function(items) applyItems(items) end

bank.updateSlot = function(bagID, slotID, item)
	local bagFrame = bagFrames[bagID]
	if not bagFrame then return end
	local slot = bagFrame.slots[slotID]
	if not slot then return end
	slot:SetItem(item)
end

bank.updateBagBar = updateBagBar
