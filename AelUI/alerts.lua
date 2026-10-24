local config = {
	point = 'BOTTOMLEFT',
	relativePoint = 'BOTTOMLEFT',
	x = 120,
	y = 460,
	scale = 0.8,
}

local positioning = false

local function positionAlerts(frame)
	if positioning then
		return
	end

	positioning = true
	frame:ClearAllPoints()
	frame:SetPoint(config.point, UIParent, config.relativePoint, config.x, config.y)
	positioning = false
end

local function scaleAlerts(frame)
	-- Blizzard parents the popups to UIParent, so they don't inherit AlertFrame's scale.
	for _, subSystem in ipairs(frame.alertFrameSubSystems) do
		if subSystem.alertFramePool then
			for alert in subSystem.alertFramePool:EnumerateActive() do
				alert:SetScale(config.scale)
			end
		elseif subSystem.anchorFrame and subSystem.anchorFrame ~= GroupLootContainer then
			subSystem.anchorFrame:SetScale(config.scale)
		end
	end
end

local handler = CreateFrame('Frame')
handler:RegisterEvent('PLAYER_LOGIN')
handler:SetScript('OnEvent', function(self)
	self:UnregisterEvent('PLAYER_LOGIN')

	-- Loot rolls are an external anchor in Blizzard's alert chain. Pass through
	-- that subsystem without letting it redirect the stack above the roll frames.
	for _, subSystem in ipairs(AlertFrame.alertFrameSubSystems) do
		if subSystem.anchorFrame and subSystem.anchorFrame == GroupLootContainer then
			subSystem.AdjustAnchors = function(_, relativeAlert)
				return relativeAlert
			end
		end
	end

	-- Keep Blizzard's queue and layout; only pin the stack's origin and scale its alerts.
	hooksecurefunc(AlertFrame, 'SetPoint', positionAlerts)
	hooksecurefunc(AlertFrame, 'UpdateAnchors', scaleAlerts)
	positionAlerts(AlertFrame)
	scaleAlerts(AlertFrame)
end)
