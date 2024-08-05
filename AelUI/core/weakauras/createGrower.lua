local _, ns = ...

ns.weakauras.createGrower = function(iconWidth, iconHeight, iconSpacing, callback)
	local prevWidth = -1

	return function(newPositions, activeRegions)
		local total = #activeRegions

		for i, regionData in ipairs(activeRegions) do
			local region = regionData.region
			region:SetRegionWidth(iconWidth)
			region:SetRegionHeight(iconHeight)

			local index = i - 1
			local xOffset = 0 - (iconWidth + iconSpacing) / 2 * (total - 1) + (index * (iconWidth + iconSpacing))

			newPositions[i] = { xOffset, 0 }
		end

		local w = (total * iconWidth) + ((total - 1) * iconSpacing)

		if w ~= prevWidth then
			prevWidth = w
			callback(w)
		end
	end
end
