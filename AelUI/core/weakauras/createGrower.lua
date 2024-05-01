local ns = select(2, ...)

ns.weakauras.createGrower = function(iconSize, iconSpacing, callback)
	local prevWidth = -1

	return function(newPositions, activeRegions)
		local total = #activeRegions

		for i, regionData in ipairs(activeRegions) do
			local region = regionData.region
			region:SetRegionWidth(iconSize)
			region:SetRegionHeight(iconSize)

			local index = i - 1
			local xOffset = 0 - (iconSize + iconSpacing) / 2 * (total - 1) + (index * (iconSize + iconSpacing))

			newPositions[i] = { xOffset, 0 }
		end

		local w = (total * iconSize) + ((total - 1) * iconSpacing)

		if w ~= prevWidth then
			prevWidth = w
			callback(w)
		end
	end
end
