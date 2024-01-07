local addon = select(2, ...)

addon.core.anchors.createUpdater = function(anchor, minWidth)
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
