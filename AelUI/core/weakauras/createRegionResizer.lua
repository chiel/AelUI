local _, ns = ...

ns.weakauras.createRegionResizer = function(regions)
	return function(width)
		for _, r in ipairs(regions) do
			local region = WeakAuras.GetRegion(r)
			if region then
				region:SetRegionWidth(width)
			end
		end
	end
end
