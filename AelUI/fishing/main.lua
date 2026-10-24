local _, ns = ...

local f = ns.fishing

local function render()
	if InCombatLockdown() then
		return
	end

	f.render(f.state)
end

local poller = CreateFrame('Frame')
poller:SetScript('OnUpdate', function()
	if f.updateEnchant() then
		render()
	end
end)

local handler = CreateFrame('Frame')
handler:RegisterEvent('BAG_UPDATE')
handler:RegisterEvent('PLAYER_EQUIPMENT_CHANGED')
handler:RegisterEvent('PLAYER_ENTERING_WORLD')
handler:RegisterEvent('PLAYER_REGEN_ENABLED')
handler:SetScript('OnEvent', function(self, event, arg1)
	if event == 'PLAYER_ENTERING_WORLD' then
		f.updateEquipment()
		f.updateLures()
		render()
	elseif event == 'PLAYER_EQUIPMENT_CHANGED' then
		if arg1 == f.mainhandSlot then
			f.updateEquipment()
			f.updateEnchant()
			render()
		end
	elseif event == 'BAG_UPDATE' then
		if f.state.hasPole then
			f.updateLures()
			f.updateEnchant()
			render()
		end
	elseif event == 'PLAYER_REGEN_ENABLED' then
		render()
	end
end)
