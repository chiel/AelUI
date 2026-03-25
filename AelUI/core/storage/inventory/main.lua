local _, ns = ...

local inv = ns.storage.inventory
local state = inv.state
local data = inv.data

-- Disable Blizzard bag frames
for i = 1, NUM_CONTAINER_FRAMES do
	local frame = _G['ContainerFrame' .. i]
	if frame then
		frame:UnregisterAllEvents()
		frame:SetScript('OnShow', nil)
		frame:SetScript('OnHide', nil)
		frame:ClearAllPoints()
	end
end

tinsert(UISpecialFrames, 'AelUIInventory')

-- inv.onHide = function()
-- 	if ns.storage.bank and ns.storage.bank.isOpen and ns.storage.bank.isOpen() then CloseBankFrame() end
-- end

-- Post-hook global bag functions to avoid tainting them.
-- Blizzard's originals run first (harmlessly on neutered frames),
-- then our hooks handle the custom container.
hooksecurefunc('ToggleBag', function() end)
hooksecurefunc('ToggleBackpack', function() end)
hooksecurefunc('ToggleAllBags', function()
	if not state.bags then state.build() end
	inv.toggle(state.bags, data.fetchAll(state.bags))
end)
hooksecurefunc('OpenAllBags', function()
	if not state.bags then state.build() end
	inv.open(state.bags, data.fetchAll(state.bags))
end)

-- Event handling
local handler = CreateFrame('Frame')
handler:RegisterEvent('BAG_UPDATE_DELAYED')
handler:RegisterEvent('BAG_UPDATE')
handler:RegisterEvent('ITEM_LOCK_CHANGED')
handler:RegisterEvent('BAG_UPDATE_COOLDOWN')
handler:RegisterEvent('QUEST_ACCEPTED')
handler:RegisterEvent('QUEST_REMOVED')
handler:SetScript('OnEvent', function(_, event, ...)
	if not inv.isBuilt() then return end

	if event == 'BAG_UPDATE' then
		local bagID = ...
		local prevSlots = state.bags and state.bags[bagID] and state.bags[bagID].numSlots or 0
		state.updateBag(bagID)
		if inv.isOpen() and state.bags[bagID].numSlots ~= prevSlots then
			inv.updateBag(bagID, state.bags[bagID].numSlots, data.fetchBag(bagID, state.bags[bagID].numSlots))
		end
		return
	end

	if not inv.isOpen() then return end

	if
		event == 'BAG_UPDATE_DELAYED'
		or event == 'BAG_UPDATE_COOLDOWN'
		or event == 'QUEST_ACCEPTED'
		or event == 'QUEST_REMOVED'
	then
		inv.updateItems(data.fetchAll(state.bags))
	elseif event == 'ITEM_LOCK_CHANGED' then
		local bagID, slotID = ...
		if bagID and slotID then inv.updateSlot(bagID, slotID, data.fetchSlot(bagID, slotID)) end
	end
end)
