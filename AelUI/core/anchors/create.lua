local _, ns = ...

ns.anchors.create = function(name)
	local minWidth = -1
	local currentWidth = -1
	local requestedWidth = -1

	local anchor = CreateFrame('Frame', name, UIParent)

	local function update()
		if UnitAffectingCombat('player') then
			return
		end

		local newWidth = requestedWidth

		if minWidth > -1 and newWidth < minWidth then
			newWidth = minWidth
		end

		if newWidth == currentWidth then
			return
		end

		anchor:SetWidth(newWidth)
		currentWidth = newWidth
	end

	anchor:SetScript('OnEvent', update)
	anchor:RegisterEvent('PLAYER_REGEN_ENABLED')

	anchor.SetMinWidth = function(self, width)
		minWidth = width
		update()
	end

	anchor.UpdateWidth = function(self, width)
		requestedWidth = width
		update()
	end

	return anchor
end
