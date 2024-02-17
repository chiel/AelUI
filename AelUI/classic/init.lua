local addon = select(2, ...)

addon.classic = {}

addon.core.events.register('PLAYER_ENTERING_WORLD', function()
	SetCVar('cameraDistanceMaxZoomFactor', 4)
end)
