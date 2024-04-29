local ns = select(2, ...)

ns.core.weakauras.createRegionResizer = function(minWidth, regions)
	return function(width)
		if regions == nil then
			return
		end

		if width < minWidth then
			width = minWidth
		end

		for _, r in ipairs(regions) do
			local region = WeakAuras.GetRegion(r.name)
			if region then
				if not r.updateChildren then
					region:SetRegionWidth(width)
				else
					-- update child regions here

					-- ViragDevTool_AddData(region, r.name)
					-- local childWidth = width / #region.sortedChildren

					-- for i, cr in ipairs(region.sortedChildren) do
					-- 	-- ViragDevTool_AddData(cr.region, 'rune' .. i)
					-- 	-- print('CHILD REGION', cr.region)
					-- 	cr.region:SetRegionWidth(math.floor(childWidth))
					-- end
				end
			end
		end
	end
end
