local _, ns = ...

local s = ns.fishing

local MAINHAND_SLOT = 16

local function render()
	if InCombatLockdown() then return end
	s.render(s.state)
end

-- Poll for enchant expiry
local poller = CreateFrame('Frame')
poller:SetScript('OnUpdate', function()
	if s.updateEnchant() then render() end
end)

-- Events
local handler = CreateFrame('Frame')
handler:RegisterEvent('PLAYER_EQUIPMENT_CHANGED')
handler:RegisterEvent('BAG_UPDATE')
handler:RegisterEvent('PLAYER_REGEN_ENABLED')
handler:SetScript('OnEvent', function(self, event, arg1)
	if event == 'PLAYER_EQUIPMENT_CHANGED' then
		if arg1 == MAINHAND_SLOT then
			s.updateEquipment()
			s.updateEnchant()
			render()
		end
	elseif event == 'BAG_UPDATE' then
		if s.state.hasPole then
			s.updateLures()
			s.updateEnchant()
			render()
		end
	elseif event == 'PLAYER_REGEN_ENABLED' then
		render()
	end
end)

ns.OnEnable(function()
	s.updateEquipment()
	s.updateLures()
	render()
end)
