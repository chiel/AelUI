local ns = select(2, ...)

local anchors = ns.anchors
local m = ns.media
local utils = ns.utils
local ce = ns.unitframes.elements

ns.unitframes.elements.classpower = function(self, unit)
	local container = CreateFrame('Frame', nil, UIParent)

	local backdrops = {}
	local classpower = {}

	for i = 1, 10 do
		local backdrop = ce.backdrop(container)
		backdrops[i] = backdrop

		if i == 1 then
			backdrop:SetPoint('TOPLEFT')
			backdrop:SetPoint('BOTTOMLEFT')
		else
			backdrop:SetPoint('TOPLEFT', backdrops[i - 1], 'TOPRIGHT', 0, 0)
			backdrop:SetPoint('BOTTOMLEFT', backdrops[i - 1], 'BOTTOMRIGHT', 0, 0)
		end

		local bar = CreateFrame('StatusBar', nil, backdrop)
		bar:SetStatusBarTexture(m.statusbars.default.file)
		bar:SetPoint('TOPLEFT', 1, -1)
		bar:SetPoint('BOTTOMRIGHT', -1, 1)

		classpower[i] = bar
	end

	local currentMax = 0
	local currentVisible = false
	local currentWidth = 0

	local function handleUpdate()
		local shouldShow = currentVisible and currentMax > 0 and currentWidth > 0
		if not shouldShow then
			if container:IsShown() then
				container:Hide()
			end

			return
		end

		if not container:IsShown() then
			container:Show()
		end

		local remainingPower = currentMax
		local remainingWidth = currentWidth

		for i = 1, currentMax do
			local widthPerPower = math.ceil(remainingWidth / remainingPower)
			backdrops[i]:SetWidth(widthPerPower)
			remainingPower = remainingPower - 1
			remainingWidth = remainingWidth - widthPerPower
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

	local function handleResize()
		currentWidth = ns.utils.round(container:GetWidth())
		handleUpdate()
	end

	anchors.primary:OnResize(handleResize)

	self.ClassPower = classpower
	return container
end
