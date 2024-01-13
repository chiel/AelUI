local addon = select(2, ...)

local anchors = addon.core.anchors

addon.classic.unitframes = {}

addon.core.events.register('PLAYER_LOGIN', function()
	TargetFrame:ClearAllPoints()
	TargetFrame:SetPoint('TOPLEFT', addon.core.anchors.primary, 'TOPRIGHT', 20, 0)
end)
