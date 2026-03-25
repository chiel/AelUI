local _, ns = ...

local function releaseSlot(slot)
	slot.bagID = nil
	slot.slotID = nil
	slot:SetAttribute('bag', nil)
	slot:SetAttribute('slot', nil)
	ns.storage.slot.release(slot)
end

local function setupSlot(slot, bagFrame, bagID, slotID, step, columns)
	slot:SetParent(bagFrame)
	slot:SetID(slotID)
	slot.bagID = bagID
	slot.slotID = slotID
	slot:SetAttribute('bag', bagID)
	slot:SetAttribute('slot', slotID)
	slot:ClearAllPoints()
	slot:SetPoint('TOPLEFT', ((slotID - 1) % columns) * step, -math.floor((slotID - 1) / columns) * step)
	slot:Show()
	bagFrame.slots[slotID] = slot
end

ns.storage.bag.build = function(parent, bagFrames, bagID, numSlots, opts)
	local columns = opts.columns
	local slotSize = opts.slotSize
	local spacing = opts.spacing

	local bagFrame = bagFrames[bagID]
	local isFixed = bagID == BANK_CONTAINER
	local step = slotSize + spacing
	if not bagFrame then
		bagFrame = CreateFrame('Frame', nil, parent)
		bagFrame:SetID(bagID)
		bagFrame.slots = {}
		bagFrames[bagID] = bagFrame

		if isFixed then
			for slotID = 1, numSlots do
				local slot = ns.storage.slot.create(bagFrame, 'BankItemButtonGenericTemplate')
				setupSlot(slot, bagFrame, bagID, slotID, step, columns)
			end
		end
	end

	if not isFixed then
		for _, slot in ipairs(bagFrame.slots) do
			releaseSlot(slot)
		end
		wipe(bagFrame.slots)

		for slotID = 1, numSlots do
			local slot = ns.storage.slot.get()
			setupSlot(slot, bagFrame, bagID, slotID, step, columns)
		end
	end

	local rows = math.ceil(numSlots / columns)
	bagFrame:SetSize(columns * step - spacing, math.max(rows * step - spacing, 1))

	return bagFrame
end
