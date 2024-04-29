local ns = select(2, ...)

ns.classic = {}

ns.core.events.register('PLAYER_ENTERING_WORLD', function()
	SetCVar('cameraDistanceMaxZoomFactor', 4)
end)
