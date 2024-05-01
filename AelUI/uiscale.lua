local ns = select(2, ...)

ns.addon:RegisterEvent('PLAYER_LOGIN', function()
	local width, height = GetPhysicalScreenSize()
	UIParent:SetScale(768 / height)
end)
