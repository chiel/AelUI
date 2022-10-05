local f = CreateFrame 'Frame'
f:SetScript('OnEvent', function()
	local height = select(2, GetPhysicalScreenSize())
	local scale = 768 / height
	UIParent:SetScale(scale)
end)
f:RegisterEvent 'PLAYER_LOGIN'
