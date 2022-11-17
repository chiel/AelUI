local addon = select(2, ...)

local playerClass = select(2, UnitClass 'player')

local function updateRegionWidths(width)
	local regions = {
		{ name = 'AelUI - Castbar', resize = true },
		{ name = 'AelUI - Power', resize = true },
		{ name = 'AelUI - Warrior - Protection - Shield Block buff', resize = playerClass == 'WARRIOR' },
		{ name = 'AelUI - Paladin - Holy Power', resize = playerClass == 'PALADIN' },
		{ name = 'AelUI - Rogue - Combo Points', resize = playerClass == 'ROGUE' },
		{ name = 'AelUI - Death Knight - Runes', resize = playerClass == 'DEATHKNIGHT', updateChildren = true },
		{ name = 'AelUI - Demon Hunter - Soul Fragments', resize = playerClass == 'DEMONHUNTER' },
		{ name = 'AelUI - Warlock - Soul Shards', resize = playerClass == 'WARLOCK' },
	}

	if width < addon.uiAnchor.minWidth then
		width = addon.uiAnchor.minWidth
	end

	for _, r in ipairs(regions) do
		if r.resize then
			local region = WeakAuras.GetRegion(r.name)
			if region then
				if not r.updateChildren then
					region:SetRegionWidth(width)
				else
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

local iconSize = addon.config.weakauras.primaryIconSize
local iconSpacing = addon.config.weakauras.primaryIconSpacing

function AelUIPrimaryGrowFunction(newPositions, activeRegions)
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

	addon.uiAnchor.UpdateWidth(w)
	updateRegionWidths(w)
end
