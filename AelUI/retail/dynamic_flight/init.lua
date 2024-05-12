local ns = select(2, ...)

local anchors = ns.anchors
local m = ns.media
local u = ns.utils

local vigorWidgetID = 4460

local vigor = {
	backdrops = {},
	bars = {},
}

vigor.container = CreateFrame('Frame', nil, UIParent)
vigor.container:SetPoint('TOPLEFT', anchors.secondary, 'BOTTOMLEFT', 0, -20)
vigor.container:SetPoint('TOPRIGHT', anchors.secondary, 'BOTTOMRIGHT', 0, -20)
vigor.container:SetHeight(6)

local secondWind = {
	backdrops = {},
	bars = {},
}

secondWind.container = CreateFrame('Frame', nil, UIParent)
secondWind.container:SetPoint('TOPLEFT', vigor.container, 'BOTTOMLEFT', 0, 1)
secondWind.container:SetPoint('TOPRIGHT', vigor.container, 'BOTTOMRIGHT', 0, 1)
secondWind.container:SetHeight(6)

local previousWidth = -1
local currentSecondWind = -1
local currentVigor = -1
local currentWidth = -1

local function updateWidths()
	if previousWidth == currentWidth or #vigor.backdrops <= 0 or #secondWind.backdrops <= 0 then
		return
	end

	previousWidth = currentWidth

	if #vigor.backdrops ~= currentVigor then
		local currentVigor = #vigor.backdrops
		local remainingVigor = currentVigor
		local remainingWidth = currentWidth

		for i, bd in pairs(vigor.backdrops) do
			local widthPerVigor = math.ceil(remainingWidth / remainingVigor)
			bd:SetWidth(widthPerVigor)
			if i == 1 then
				bd:SetPoint('TOPLEFT', 0, 0)
			else
				bd:SetPoint('TOPLEFT', vigor.backdrops[i - 1], 'TOPRIGHT', 0, 0)
			end

			remainingWidth = remainingWidth - widthPerVigor
			remainingVigor = remainingVigor - 1
		end
	end

	if #secondWind.backdrops ~= currentSecondWind then
		local currentSecondWind = #secondWind.backdrops
		local remainingCharges = #secondWind.backdrops
		local remainingWidth = currentWidth

		for i, bd in pairs(secondWind.backdrops) do
			local widthPerCharge = math.ceil(remainingWidth / remainingCharges)
			bd:SetWidth(widthPerCharge)
			if i == 1 then
				bd:SetPoint('TOPLEFT', 0, 0)
			else
				bd:SetPoint('TOPLEFT', secondWind.backdrops[i - 1], 'TOPRIGHT', 0, 0)
			end

			remainingWidth = remainingWidth - widthPerCharge
			remainingCharges = remainingCharges - 1
		end
	end
end

ns.addon:RegisterEvent('UPDATE_UI_WIDGET', function(event, data)
	local backdrops, bars, container = vigor.backdrops, vigor.bars, vigor.container

	if data.widgetID ~= vigorWidgetID then
		return
	end

	local info = C_UIWidgetManager.GetFillUpFramesWidgetVisualizationInfo(vigorWidgetID)
	if not info then
		return
	end

	if info.shownState == Enum.WidgetShownState.Hidden then
		if container:IsShown() then
			container:Hide()
		end

		if secondWind.container:IsShown() then
			secondWind.container:Hide()
		end

		return
	end

	if UIWidgetPowerBarContainerFrame then
		local vigorContainer = UIWidgetPowerBarContainerFrame.widgetFrames[vigorWidgetID]
		if vigorContainer and vigorContainer:IsShown() then
			vigorContainer:Hide()
		end
	end

	if not container:IsShown() then
		container:Show()
	end

	if not secondWind.container:IsShown() then
		secondWind.container:Show()
	end

	for i = 1, info.numTotalFrames do
		if not bars[i] then
			backdrops[i] = u.addBackdrop(container)
			backdrops[i]:SetHeight(6)

			bars[i] = CreateFrame('StatusBar', nil, backdrops[i])
			bars[i]:SetPoint('TOPLEFT', 1, -1)
			bars[i]:SetPoint('BOTTOMRIGHT', -1, 1)
			bars[i]:SetStatusBarTexture(m.statusbars.default.file)
			bars[i]:SetStatusBarColor(156 / 255, 218 / 255, 244 / 255)
			bars[i]:SetMinMaxValues(info.fillMin, info.fillMax)
			ns.utils.setSmoothing(bars[i], true)
		end

		if info.numFullFrames >= i then
			bars[i]:SetValue(info.fillMax)
			bars[i]:SetAlpha(1)
		elseif info.numFullFrames + 1 == i then
			bars[i]:SetValue(info.fillValue)
			bars[i]:SetAlpha(0.5)
		else
			bars[i]:SetValue(info.fillMin)
			bars[i]:SetAlpha(0)
		end
	end

	updateWidths()
end)

-- local bd = u.addBackdrop(secondWind.container)
-- bd:SetAllPoints()

ns.addon:RegisterEvent('SPELL_UPDATE_COOLDOWN', function()
	local backdrops, bars, container = secondWind.backdrops, secondWind.bars, secondWind.container

	local currentCharges, maxCharges, cooldownStart, cooldownDuration = GetSpellCharges(425782)

	for i = 1, maxCharges do
		if not bars[i] then
			backdrops[i] = u.addBackdrop(container)
			backdrops[i]:SetHeight(6)

			bars[i] = CreateFrame('StatusBar', nil, backdrops[i])
			bars[i]:SetPoint('TOPLEFT', 1, -1)
			bars[i]:SetPoint('BOTTOMRIGHT', -1, 1)
			bars[i]:SetStatusBarTexture(m.statusbars.default.file)
			bars[i]:SetStatusBarColor(254 / 255, 183 / 255, 134 / 255)
			bars[i]:SetMinMaxValues(0, 100)
			ns.utils.setSmoothing(bars[i], true)
		end

		if currentCharges >= i then
			bars[i]:SetValue(100)
			bars[i]:SetAlpha(1)
		elseif currentCharges + 1 == i then
			local remaining = cooldownStart + cooldownDuration - GetTime()
			local percent = (cooldownDuration - remaining) / cooldownDuration * 100
			bars[i]:SetValue(percent)
			bars[i]:SetAlpha(0.5)
		else
			bars[i]:SetValue(0)
			bars[i]:SetAlpha(0)
		end
	end
end)

anchors.secondary:OnResize(function(width)
	if width == currentWidth then
		return
	end

	currentWidth = width
	updateWidths()
end)
