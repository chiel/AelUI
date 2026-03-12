local _, ns = ...

local s = ns.lootrolls
local render = function()
	s.render(s.rolls)
end

local handler = CreateFrame('Frame')
handler:RegisterEvent('START_LOOT_ROLL')
handler:RegisterEvent('CANCEL_LOOT_ROLL')
handler:RegisterEvent('LOOT_HISTORY_ROLL_CHANGED')
handler:RegisterEvent('LOOT_HISTORY_ROLL_COMPLETE')
handler:SetScript('OnEvent', function(_, event, ...)
	if event == 'START_LOOT_ROLL' then
		s.onStartRoll(...)
	elseif event == 'CANCEL_LOOT_ROLL' then
		s.onCancelRoll(...)
	elseif event == 'LOOT_HISTORY_ROLL_CHANGED' then
		s.onRollChanged(...)
	elseif event == 'LOOT_HISTORY_ROLL_COMPLETE' then
		s.onRollComplete()
	end
	render()
end)

UIParent:UnregisterEvent('START_LOOT_ROLL')
UIParent:UnregisterEvent('CANCEL_LOOT_ROLL')
