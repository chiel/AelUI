local addon = select(2, ...)

local anchorOffset = addon.utils.Round((addon.config.screenSize.height / 16) * 3)
local iconSize = addon.config.weakauras.primaryIconSize
local iconSpacing = addon.config.weakauras.primaryIconSpacing

local anchor = CreateFrame('Frame', 'AelUIAnchor', UIParent)
anchor:SetPoint('TOP', UIParent, 'CENTER', 0, -anchorOffset)
anchor:SetWidth((8 * iconSize) + (7 * iconSpacing))
anchor:SetHeight(iconSize)

local updatePending = false
anchor.UpdateWidth = function(width)
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

addon.uiAnchor = anchor
