local addon = select(2, ...)

local ufHeight = addon.config.unitframes.height
local c = addon.config.core.anchors

addon.core.anchors = {}

local function createWidthUpdater(anchor, minWidth)
	local currentWidth = -1
	local pendingWidth = -1

	local function update()
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

	local updater = CreateFrame('Frame')
	updater:SetScript('OnEvent', update)
	updater:RegisterEvent('PLAYER_REGEN_ENABLED')

	return function(width)
		if width < minWidth then
			width = minWidth
		end

		pendingWidth = width

		if not UnitAffectingCombat('player') then
			update()
		end
	end
end

-- primary anchor
local anchorOffset = addon.utils.Round((addon.config.screenSize.height / 16) * 3)
local primaryAnchor = CreateFrame('Frame', 'AelUIPrimaryAnchor', UIParent)
primaryAnchor:SetPoint('TOP', UIParent, 'CENTER', 0, -anchorOffset)
primaryAnchor:SetSize(c.primary.minWidth, c.primary.height)
primaryAnchor.UpdateWidth = createWidthUpdater(primaryAnchor, c.primary.minWidth)
addon.core.anchors.primary = primaryAnchor

-- secondary anchor
local secondaryAnchor = CreateFrame('Frame', 'AelUISecondaryAnchor', UIParent)
secondaryAnchor:SetPoint('TOP', primaryAnchor, 'BOTTOM', 0, -2)
secondaryAnchor:SetSize(c.secondary.minWidth, c.secondary.height)
secondaryAnchor.UpdateWidth = createWidthUpdater(secondaryAnchor, c.secondary.minWidth)
addon.core.anchors.secondary = secondaryAnchor

-- group anchor
local groupAnchor = CreateFrame('Frame', 'AelUIGroupAnchor', UIParent)
groupAnchor:SetPoint('TOPRIGHT', primaryAnchor, 'TOPLEFT', -((ufHeight * 8) + 20 + 4), ufHeight * (5 + 2 + (1.5 * 4)))
groupAnchor:SetSize(1, 1)
addon.core.anchors.group = groupAnchor

--
-- DEPRECATED STUFF BELOW
--
AelUIAnchor = AelUIPrimaryAnchor
addon.uiAnchor = primaryAnchor
addon.uiGroupAnchor = groupAnchor
