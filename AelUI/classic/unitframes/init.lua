local ns = select(2, ...)

local anchors = ns.core.anchors

ns.classic.unitframes = {}

ns.core.events.register('PLAYER_LOGIN', function()
	TargetFrame:ClearAllPoints()
	TargetFrame:SetPoint('TOPLEFT', ns.core.anchors.primary, 'TOPRIGHT', 20, 0)
end)
