local _, ns = ...

local h = ns.helpers
local m = ns.media

local handler = CreateFrame('Frame')
handler:RegisterEvent('PLAYER_ENTERING_WORLD')
handler:SetScript('OnEvent', function()
	MinimapCluster.BorderTop:Hide()
	MinimapToggleButton:Hide()
	MinimapBorder:Hide()
	MinimapZoomIn:Hide()
	MinimapZoomOut:Hide()
	MinimapNorthTag:Hide()

	-- square minimap
	local mapBd, mapBg = h.createBackdrop(AelUIParent)
	mapBd:SetSize(240, 240)
	mapBd:SetPoint('TOPRIGHT', AelUIParent, 'TOPRIGHT', -16, -16)

	Minimap:SetMaskTexture([[interface\chatframe\chatframebackground]])
	Minimap:SetParent(mapBd)
	Minimap:ClearAllPoints()
	Minimap:SetSize(238, 238)
	Minimap:SetPoint('CENTER', mapBd, 'CENTER', 0, 0)

	MinimapBackdrop:ClearAllPoints()
	MinimapBackdrop:SetAllPoints(Minimap)

	-- zone text (show on hover)
	local btn = MinimapZoneTextButton
	btn:SetParent(Minimap)
	btn:ClearAllPoints()
	btn:SetPoint('TOPLEFT', Minimap, 'TOPLEFT', 0, 0)
	btn:SetPoint('TOPRIGHT', Minimap, 'TOPRIGHT', 0, 0)
	btn:SetHeight(24)
	btn:Hide()

	MinimapZoneText:SetFont(m.fonts.default.file, 18, 'OUTLINE')
	MinimapZoneText:ClearAllPoints()
	MinimapZoneText:SetAllPoints(btn)

	Minimap:HookScript('OnEnter', function()
		btn:Show()
	end)
	Minimap:HookScript('OnLeave', function()
		btn:Hide()
	end)

	-- clock
	for _, region in next, { TimeManagerClockButton:GetRegions() } do
		if region:IsObjectType('Texture') then
			region:Hide()
		end
	end

	TimeManagerClockTicker:SetFont(m.fonts.default.file, 24, 'OUTLINE')

	TimeManagerClockButton:SetHeight(24)
	TimeManagerClockButton:ClearAllPoints()
	TimeManagerClockButton:SetPoint('BOTTOM', Minimap, 'BOTTOM', 0, 0)
end)
