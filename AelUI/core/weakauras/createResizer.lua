local _, ns = ...

ns.weakauras.createResizer = function(regions)
	return function(width)
		if WeakAuras == nil then
			return
		end

		for _, r in ipairs(regions) do
			local region = WeakAuras.GetRegion(r)
			if region then
				region:SetRegionWidth(width)
			end
		end
	end
end
