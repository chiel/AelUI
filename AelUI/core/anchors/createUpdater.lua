local ns = select(2, ...)

ns.anchors.createUpdater = function(anchor, minWidth)
	local minWidth = minWidth
	local currentWidth = -1
	local requestedWidth = -1

	local function update()
		local newWidth = requestedWidth

		if newWidth < minWidth then
			newWidth = minWidth
		end

		if newWidth == currentWidth then
			return
		end

		anchor:SetWidth(newWidth)
		currentWidth = newWidth
	end

	local updater = CreateFrame('Frame')
	updater:SetScript('OnEvent', update)
	updater:RegisterEvent('PLAYER_REGEN_ENABLED')

	return {
		SetMinWidth = function(width)
			minWidth = width

			if not UnitAffectingCombat('player') then
				update()
			end
		end,

		SetWidth = function(width)
			requestedWidth = width

			if not UnitAffectingCombat('player') then
				update()
			end
		end,
	}
end
