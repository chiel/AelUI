local addon = select(2, ...)

addon.core.events.register('PLAYER_LOGIN', function()
	UIParent:SetScale(768 / addon.core.config.screenSize.height)
end)
