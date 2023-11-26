local addon = select(2, ...)

local f = CreateFrame('Frame')
f:SetScript('OnEvent', function()
	UIParent:SetScale(768 / addon.config.screenSize.height)
end)
f:RegisterEvent('PLAYER_LOGIN')
