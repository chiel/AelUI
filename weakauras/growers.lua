local addon = select(2, ...)

local playerClass = select(2, UnitClass 'player')

local function updateRegionWidths(width)
	local regions = {
		{ name = 'AelUI - Castbar', resize = true },
		{ name = 'AelUI - Power', resize = true },

		{ name = 'AelUI - Death Knight - Runes', resize = playerClass == 'DEATHKNIGHT', updateChildren = true },
		{ name = 'AelUI - Demon Hunter - Vengeance - Soul Fragments', resize = playerClass == 'DEMONHUNTER' },
		{ name = 'AelUI - Evoker - Essence', resize = playerClass == 'EVOKER' },
		{ name = 'AelUI - Monk - Windwalker - Chi', resize = playerClass == 'MONK' },
		{ name = 'AelUI - Paladin - Holy Power', resize = playerClass == 'PALADIN' },
		{ name = 'AelUI - Rogue - Combo Points', resize = playerClass == 'ROGUE' },
		{ name = 'AelUI - Shaman - Enhancement - Maelstrom Weapon', resize = playerClass == 'SHAMAN' },
		{ name = 'AelUI - Warlock - Soul Shards', resize = playerClass == 'WARLOCK' },
		{ name = 'AelUI - Warrior - Fury - Enrage buff', resize = playerClass == 'WARRIOR' },
		{ name = 'AelUI - Warrior - Protection - Shield Block buff', resize = playerClass == 'WARRIOR' },
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

local prevWidth = -1

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

	if w ~= prevWidth then
		addon.uiAnchor.UpdateWidth(w)
		updateRegionWidths(w)
		prevWidth = w
	end
end
