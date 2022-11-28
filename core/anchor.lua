local addon = select(2, ...)

local ufHeight = addon.config.unitframes.height

local anchorOffset = addon.utils.Round((addon.config.screenSize.height / 16) * 3)
local iconSize = addon.config.weakauras.primaryIconSize
local iconSpacing = addon.config.weakauras.primaryIconSpacing
local minIcons = 7
local minWidth = (minIcons * iconSize) + ((minIcons - 1) * iconSpacing)

local anchor = CreateFrame('Frame', 'AelUIAnchor', UIParent)
anchor:SetPoint('TOP', UIParent, 'CENTER', 0, -anchorOffset)
anchor:SetWidth(minWidth)
anchor:SetHeight(iconSize)

local groupAnchor = CreateFrame('Frame', 'AelUIGroupAnchor', UIParent)
groupAnchor:SetPoint('TOPRight', anchor, 'TOPLEFT', -((ufHeight * 8) + 20 + 4), ufHeight * (5 + 2 + (1.5 * 4)))
groupAnchor:SetWidth(1)
groupAnchor:SetHeight(1)

local updatePending = false
anchor.UpdateWidth = function(width)
	if width < minWidth then
		width = minWidth
	end

	local currentWidth = addon.utils.Round(anchor:GetWidth())
	if width == currentWidth then
		return
	end

	local function doUpdate()
		anchor:SetWidth(width)
		updatePending = false
	end

	local inCombat = UnitAffectingCombat 'player'
	if not inCombat then
		doUpdate()
		return
	end

	if not updatePending then
		updatePending = true
		local f = CreateFrame 'Frame'
		f:SetScript('OnEvent', function()
			doUpdate()
		end)
		f:RegisterEvent 'PLAYER_REGEN_ENABLED'
	end
end

anchor.minWidth = minWidth

addon.uiAnchor = anchor
addon.uiGroupAnchor = groupAnchor
