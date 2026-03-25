local _, ns = ...

local bank = ns.storage.bank
local state = bank.state
local data = bank.data
local inv = ns.storage.inventory

-- Disable default bank frame
BankFrame:UnregisterAllEvents()
BankFrame:SetScript('OnShow', nil)
BankFrame:SetScript('OnHide', nil)
BankFrame:ClearAllPoints()
hooksecurefunc(BankFrame, 'SetPoint', BankFrame.ClearAllPoints)

-- Event handling
local handler = CreateFrame('Frame')
handler:RegisterEvent('BANKFRAME_OPENED')
handler:RegisterEvent('BANKFRAME_CLOSED')
handler:RegisterEvent('BAG_UPDATE_DELAYED')
handler:RegisterEvent('BAG_UPDATE')
handler:RegisterEvent('PLAYERBANKSLOTS_CHANGED')
handler:RegisterEvent('PLAYERBANKBAGSLOTS_CHANGED')
handler:RegisterEvent('ITEM_LOCK_CHANGED')
handler:SetScript('OnEvent', function(_, event, ...)
	if event == 'BANKFRAME_OPENED' then
		if not inv.isOpen() then OpenAllBags() end
		state.build()
		bank.open(state.bags, data.fetchAll(state.bags))
		return
	elseif event == 'BANKFRAME_CLOSED' then
		bank.close()
		if inv.isOpen() then ToggleAllBags() end
		return
	end

	if not bank.isOpen() then return end

	if event == 'BAG_UPDATE' then
		local bagID = ...
		local prevSlots = state.bags and state.bags[bagID] and state.bags[bagID].numSlots or 0
		state.updateBag(bagID)
		if state.bags[bagID] and state.bags[bagID].numSlots ~= prevSlots then
			bank.updateBag(bagID, state.bags[bagID].numSlots, data.fetchBag(bagID, state.bags[bagID].numSlots))
		end
	elseif event == 'BAG_UPDATE_DELAYED' or event == 'PLAYERBANKSLOTS_CHANGED' then
		bank.updateItems(data.fetchAll(state.bags))
	elseif event == 'PLAYERBANKBAGSLOTS_CHANGED' then
		bank.updateBagBar()
	elseif event == 'ITEM_LOCK_CHANGED' then
		local bagID, slotID = ...
		if bagID and slotID then
			bank.updateSlot(bagID, slotID, data.fetchSlot(bagID, slotID))
		end
	end
end)
