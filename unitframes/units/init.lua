local addon = select(2, ...)

addon.units = {}

local playerClass = select(2, UnitClass 'player')

local function updateRegionWidths(width)
	local regions = {
		{ name = 'CASTBAR', resize = true },
		{ name = 'GCD', resize = true },
		{ name = 'POWER', resize = true },
		{ name = 'PALADIN - Holy Power', resize = playerClass == 'PALADIN' },
		{ name = 'ROGUE - Combo Points', resize = playerClass == 'ROGUE' },
		{ name = 'DEATHKNIGHT - Runes', resize = playerClass == 'DEATHKNIGHT', updateChildren = true },
		{ name = 'DEMONHUNTER - Soul Fragments', resize = playerClass == 'DEMONHUNTER' },
		{ name = 'WARLOCK - Soul Shards', resize = playerClass == 'WARLOCK' },
	}

	for _, r in ipairs(regions) do
		if r.resize then
			local region = WeakAuras.GetRegion(r.name)
			if region then
				if not r.updateChildren then
					region:SetRegionWidth(width)
				else
					-- to be implemented
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
