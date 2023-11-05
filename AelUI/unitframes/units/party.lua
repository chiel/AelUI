local addon = select(2, ...)

local ufConfig = addon.config.unitframes

-- local debuffBlacklist = {
-- 	-- lust debuffs
-- 	57724,
-- 	80354,
-- 	390435,

-- 	206151, -- challenger's burden
-- }

-- local debuffBlacklistMap = {}

-- for _, debuffId in ipairs(debuffBlacklist) do
-- 	debuffBlacklistMap[debuffId] = true
-- end

-- local function formatTime(seconds)
-- 	if seconds > 60 then
-- 		return string.format('%i:', math.floor(seconds / 60)) .. string.format('%02i', seconds % 60)
-- 	end

-- 	return string.format('%d', seconds)
-- end

-- local function FilterAura(self, unit, data)
-- 	return data.name and not debuffBlacklistMap[data.spellId]
-- end

-- local function PostCreateButton(self, button)
-- 	local cd = button.Cooldown
-- 	cd:SetReverse(true)
-- 	cd:SetDrawEdge(false)
-- 	-- cd:SetCountdownFont(addon.media.fontBold)
-- 	cd:SetHideCountdownNumbers(true)

-- 	local count = button.Count
-- 	count:ClearAllPoints()
-- 	count:SetPoint('TOPRIGHT', -2, -2)
-- 	count:SetFont(addon.media.fontBold, 12, 'OUTLINE')

-- 	local border = CreateFrame('Frame', nil, button, 'BackdropTemplate')
-- 	border:SetBackdrop { edgeFile = addon.media.border, edgeSize = 2 }
-- 	border:SetBackdropBorderColor(0, 0, 0, 1)
-- 	border:SetPoint 'TOPLEFT'
-- 	border:SetPoint 'BOTTOMRIGHT'

-- 	local progressFrame = CreateFrame('Frame', nil, button)
-- 	progressFrame:SetAllPoints()
-- 	progressFrame:SetFrameLevel(cd:GetFrameLevel() + 1)

-- 	local progress = progressFrame:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
-- 	progress:SetFont(addon.media.fontBold, 14, 'OUTLINE')
-- 	progress:SetTextColor(1, 1, 1)
-- 	progress:SetPoint('BOTTOM', button, 'BOTTOM', 0, -1)
-- 	button.Progress = progress
-- end

-- local function PostUpdateButton(self, button, unit, data, position)
-- 	if data.duration > 0 then
-- 		local seconds = data.expirationTime - GetTime()
-- 		-- local sec = math.floor(math.fmod(seconds, 60) + 0.5)
-- 		-- local value = tostring(sec)

-- 		-- if seconds > 59 then
-- 		-- 	local min = math.floor(seconds / 60)
-- 		-- 	value = string.format('%d:%s', min, value)
-- 		-- end

-- 		button.Progress:SetText(formatTime(seconds))
-- 	else
-- 		button.Progress:SetText ''
-- 	end
-- end

addon.units.party = {
	spawn = function(self)
		local party = self:SpawnHeader(
			nil,
			nil,
			'party',
			'showParty',
			true,
			'showPlayer',
			true,
			'yOffset',
			-(ufConfig.height * 1.5),
			'groupBy',
			'ASSIGNEDROLE',
			'groupingOrder',
			'TANK,HEALER,DAMAGER',
			'oUF-initialConfigFunction',
			([[
				self:SetWidth(%d)
				self:SetHeight(%d)
			]]):format(ufConfig.height * 7, ufConfig.height)
		)

		party:SetPoint('TOPRIGHT', addon.uiGroupAnchor, 'TOPLEFT')
	end,

	style = function(self, unit)
		addon.unitframes.style(self, unit)

		-- local iconSize = 32
		-- local iconSpacing = 2

		-- local debuffs = CreateFrame('Frame', nil, self)
		-- debuffs:SetPoint('TOPLEFT', self, 'TOPRIGHT', iconSpacing * 2, -44)
		-- debuffs:SetSize((iconSize + iconSpacing) * 10, iconSize)
		-- debuffs.size = iconSize
		-- debuffs.spacing = iconSpacing
		-- debuffs.initialAnchor = 'TOPLEFT'
		-- debuffs['growth-x'] = 'RIGHT'

		-- debuffs.FilterAura = FilterAura
		-- debuffs.PostCreateButton = PostCreateButton
		-- debuffs.PostUpdateButton = PostUpdateButton

		-- -- self.Debuffs = debuffs
		-- self.Buffs = debuffs
	end,
}
