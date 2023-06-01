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

local currentWidth = -1
local pendingWidth = -1

local function updateAnchorWidth()
	if pendingWidth == currentWidth then
		pendingWidth = -1
		return
	end

	if pendingWidth == -1 then
		return
	end

	anchor:SetWidth(pendingWidth)
	currentWidth = pendingWidth
	pendingWidth = -1
end

local anchorUpdates = CreateFrame 'Frame'
anchorUpdates:SetScript('OnEvent', function()
	updateAnchorWidth()
end)
anchorUpdates:RegisterEvent 'PLAYER_REGEN_ENABLED'

anchor.UpdateWidth = function(width)
	if width < minWidth then
		width = minWidth
	end

	pendingWidth = width

	local inCombat = UnitAffectingCombat 'player'
	if not inCombat then
		updateAnchorWidth()
		return
	end
end

anchor.minWidth = minWidth

addon.uiAnchor = anchor
addon.uiGroupAnchor = groupAnchor
