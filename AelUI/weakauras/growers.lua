local addon = select(2, ...)

AelUI.weakauras.growers = {}
local c = addon.config.weakauras
local anchorConfig = addon.config.core.anchors
local anchors = addon.core.anchors

local playerClass = select(2, UnitClass('player'))

local primaryRegions = {
	{ name = 'AelUI - Castbar', resize = true },
	{ name = 'AelUI - Power', resize = true },

	{ name = 'AelUI - Class - Evoker - Augmentation - Aura - Ebon Might', resize = playerClass == 'EVOKER' },
	{ name = 'AelUI - Class - Evoker - Augmentation - Aura - Hover', resize = playerClass == 'EVOKER' },
	{ name = 'AelUI - Class - Evoker - Devastation - Aura - Hover', resize = playerClass == 'EVOKER' },
	{ name = 'AelUI - Class - Monk - Mistweaver - Aura - Ancient Teachings', resize = playerClass == 'MONK' },
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

local secondaryRegions = {
	{ name = 'AelUI - GCD', resize = true },
}

local function updateRegionWidths(regions, width, minWidth)
	if width < minWidth then
		width = minWidth
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

local function createGrower(iconSize, iconSpacing, callback)
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

AelUI.weakauras.growers.primary = createGrower(c.primaryIconSize, c.primaryIconSpacing, function(width)
	anchors.primary.UpdateWidth(width)
	updateRegionWidths(primaryRegions, width, anchorConfig.primary.minWidth)
end)

AelUI.weakauras.growers.secondary = createGrower(c.secondaryIconSize, c.secondaryIconSpacing, function(width)
	anchors.secondary.UpdateWidth(width)
	updateRegionWidths(secondaryRegions, width, anchorConfig.secondary.minWidth)
end)
