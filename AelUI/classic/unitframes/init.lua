local addon = select(2, ...)

addon.core.events.register('PLAYER_LOGIN', function()
	PlayerFrame:ClearAllPoints()
	PlayerFrame:SetPoint('TOPRIGHT', addon.core.anchors.primary, 'TOPLEFT', -20, 0)

	TargetFrame:ClearAllPoints()
	TargetFrame:SetPoint('TOPLEFT', addon.core.anchors.primary, 'TOPRIGHT', 20, 0)
end)
