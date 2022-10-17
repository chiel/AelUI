local addon = select(2, ...)

addon.units = {}

local playerClass = select(2, UnitClass 'player')
local iconSize = addon.config.unitframes.height
local iconSpacing = 2

local anchorOffset = addon.utils.Round((addon.config.screenSize.height / 16) * 3)

local anchor = CreateFrame('Frame', 'AelUIAnchor', UIParent)
anchor:SetPoint('TOP', UIParent, 'CENTER', 0, -anchorOffset)
anchor:SetWidth((8 * iconSize) + (7 * 2))
anchor:SetHeight(iconSize)
addon.uiAnchor = anchor

local updatePending = false

local function updateAnchorWidth(width)
	local function doUpdate()
		anchor:SetWidth(width)
		updatePending = false
	end

	local inCombat = UnitAffectingCombat 'player'
	if not inCombat then
		doUpdate()
		return
	end

	if not updatePending then
		updatePending = true
		local f = CreateFrame 'Frame'
		f:SetScript('OnEvent', function()
			doUpdate()
		end)
		f:RegisterEvent 'PLAYER_REGEN_ENABLED'
	end
end

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

	updateAnchorWidth(w)
	updateRegionWidths(w)
end
