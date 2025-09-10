local _, ns = ...

local e = ns.unitframes.elements
local m = ns.media
local u = ns.utils

ns.unitframes.elements.classpower = function(self, unit)
	local container = CreateFrame('Frame', nil, self)
	local backdrops = {}
	local classpower = {}

	for i = 1, 10 do
		local backdrop = e.backdrop(container)
		backdrop:SetPoint('TOP')
		if i == 1 then
			backdrop:SetPoint('BOTTOMLEFT', 0)
		else
			backdrop:SetPoint('BOTTOMLEFT', backdrops[i - 1], 'BOTTOMRIGHT', -1, 0)
		end
		backdrops[i] = backdrop

		local bar = CreateFrame('StatusBar', nil, backdrop)
		bar:SetStatusBarTexture(m.statusbars.default.file)
		bar:SetPoint('TOPLEFT', 1, -1)
		bar:SetPoint('BOTTOMRIGHT', -1, 1)
		classpower[i] = bar
	end

	local currentMax = nil
	local currentVisible = false
	local currentWidth = 0

	local function handleUpdate()
		local shouldShow = currentVisible and currentMax ~= nil and currentMax > 0 and currentWidth > 0
		if not shouldShow then
			if container:IsShown() then
				container:Hide()
			end

			return
		end

		if not container:IsShown() then
			container:Show()
		end

		container:SetWidth(currentWidth)
		local remainingWidth = currentWidth + (currentMax - 1)
		for i = 1, currentMax do
			local barWidth = u.round(remainingWidth / ((currentMax + 1) - i))
			backdrops[i]:Show()
			backdrops[i]:SetWidth(barWidth)
			remainingWidth = remainingWidth - barWidth
		end

		for i = currentMax + 1, 10 do
			backdrops[i]:Hide()
		end
	end

	classpower.PostUpdate = function(self, cur, max, hasMaxChanged)
		currentMax = max
		handleUpdate()
	end

	classpower.PostVisibility = function(self, isVisible)
		currentVisible = isVisible
		handleUpdate()
	end

	container.UpdateWidth = function(self, width)
		currentWidth = width
		handleUpdate()
	end

	self.ClassPower = classpower
	return container
end
