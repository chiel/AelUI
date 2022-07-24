local f = CreateFrame 'Frame'
f:SetScript('OnEvent', function()
	local scale = 768 / 1600
	UIParent:SetScale(scale)
end)
f:RegisterEvent 'PLAYER_LOGIN'
