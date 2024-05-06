local ns = select(2, ...)

ns.anchors.createUpdater = function(anchor, minWidth)
	local minWidth = minWidth
	local currentWidth = -1
	local requestedWidth = -1
	local onResize

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

		if onResize ~= nil then
			onResize(newWidth)
		end
	end

	local updater = CreateFrame('Frame')
	updater:SetScript('OnEvent', update)
	updater:RegisterEvent('PLAYER_REGEN_ENABLED')

	return {
		OnResize = function(callback)
			onResize = callback
		end,

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
