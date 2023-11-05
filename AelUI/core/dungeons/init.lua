local addon = select(2, ...)

local cm = C_ChallengeMode

local mapInfoMap = {
	[206] = { -- Neltharion's Lair
		name = 'NL',
		spellId = 410078,
		-- spellId = 17,
	},
	[245] = { -- Freehold
		name = 'FH',
		spellId = 410071,
	},
	[251] = { -- The Underrot
		name = 'UR',
		spellId = 410074,
	},
	[403] = { -- Uldaman: Legacy of Tyr
		name = 'ULD',
		spellId = 393222,
	},
	[404] = { -- Neltharus
		name = 'NELT',
		spellId = 393276,
	},
	[405] = { -- Brackenhide Hollow
		name = 'BH',
		spellId = 393267,
	},
	[406] = { -- Halls of Infusion
		name = 'HOI',
		spellId = 393283,
	},
	[438] = { -- The Vortex Pinnacle
		name = 'VP',
		spellId = 410080,
	},
}

local teleports = {
	buttons = {},
	-- cache = {},
	-- offset = { 14, 30 },
	size = 32,
	-- spacing = 4,
}

-- function teleports:CreateButton(parent, mapId)
-- 	local mapInfo = mapInfoMap[mapId]
-- 	if not mapInfo then
-- 		return
-- 	end

-- 	if not IsSpellKnown(mapInfo.spellId) then
-- 		return
-- 	end

-- 	local button = CreateFrame('Button', nil, parent, 'UIPanelButtonTemplate')

-- 	button:SetAttribute('type', 'spell')
-- 	button:SetAttribute('spell', mapInfo.spellId)
-- 	button:SetAttribute('unit', 'player')
-- 	button:RegisterForClicks('LeftButtonUp', 'LeftButtonDown')

-- 	-- button:SetSize(self.size, self.size)
-- 	button:SetPoint('BOTTOM', 0, 0)

-- 	-- 	local text = button:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
-- 	-- 	text:SetFont(addon.media.fontBold, 10, 'OUTLINE')
-- 	-- 	text:SetJustifyH 'CENTER'
-- 	-- 	text:SetTextColor(1, 1, 1)
-- 	-- 	text:SetText(mapInfo.name)
-- 	-- 	text:SetPoint('BOTTOM', 2, -1)

-- 	-- 	local tx = button:CreateTexture()
-- 	-- 	tx:SetAllPoints()
-- 	-- 	tx:SetTexture(GetSpellTexture(mapInfo.spellId))

-- 	-- 	local cd = CreateFrame('Cooldown', nil, button, 'CooldownFrameTemplate')
-- 	-- 	cd:SetDrawEdge(false)
-- 	-- 	cd:SetAllPoints()
-- 	-- 	button.cd = cd

-- 	return button
-- end

-- function teleports:OnUpdate()
-- 	for i = 1, #ChallengesFrame.DungeonIcons do
-- 		local icon = ChallengesFrame.DungeonIcons[i]
-- 		local button = self.buttons[icon.mapID] or self:CreateButton(icon, icon.mapID)
-- 		if button then
-- 			-- print('got button!', button)
-- 			-- print('icon!', icon.mapID)
-- 		end
-- 	end
-- end

-- function teleports:init()
-- 	self:createButtons()

-- 	print('total icons', #ChallengesFrame.DungeonIcons)

-- 	for i = 1, #ChallengesFrame.DungeonIcons do
-- 		local icon = ChallengesFrame.DungeonIcons[i]
-- 		print('icon', i, icon)
-- 	end
-- end

-- function teleports:createButton(mapId)
-- 	local mapInfo = mapInfoMap[mapId]
-- 	if not mapInfo then
-- 		return
-- 	end

-- 	if not IsSpellKnown(mapInfo.spellId) then
-- 		return
-- 	end

-- 	local button = CreateFrame('Button', nil, ChallengesFrame, 'SecureActionButtonTemplate')
-- 	button:SetAttribute('type', 'spell')
-- 	button:SetAttribute('spell', mapInfo.spellId)
-- 	button:SetAttribute('unit', 'player')
-- 	button:RegisterForClicks('LeftButtonUp', 'LeftButtonDown')

-- 	button:SetScript('OnEnter', function(self)
-- 		GameTooltip:SetOwner(self, 'ANCHOR_NONE')
-- 		GameTooltip:SetPoint('TOPLEFT', self, 'TOPRIGHT', 10, 0)
-- 		GameTooltip:SetSpellByID(mapInfo.spellId)
-- 	end)

-- 	button:SetScript('OnLeave', function(self)
-- 		GameTooltip:Hide()
-- 	end)

-- 	local text = button:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
-- 	text:SetFont(addon.media.fontBold, 10, 'OUTLINE')
-- 	text:SetJustifyH 'CENTER'
-- 	text:SetTextColor(1, 1, 1)
-- 	text:SetText(mapInfo.name)
-- 	text:SetPoint('BOTTOM', 2, -1)

-- 	local tx = button:CreateTexture()
-- 	tx:SetAllPoints()
-- 	tx:SetTexture(GetSpellTexture(mapInfo.spellId))

-- 	local cd = CreateFrame('Cooldown', nil, button, 'CooldownFrameTemplate')
-- 	cd:SetDrawEdge(false)
-- 	cd:SetAllPoints()
-- 	button.cd = cd

-- 	return button
-- end

-- function teleports:createButtons()
-- 	local shown = 0

-- 	for _, mapId in ipairs(cm.GetMapTable()) do
-- 		local button = self:createButton(mapId)

-- 		if button then
-- 			self.cache[mapId] = button
-- 			button:SetSize(self.size, self.size)
-- 			button:SetPoint(
-- 				'TOPRIGHT',
-- 				ChallengesFrame,
-- 				'TOPRIGHT',
-- 				-self.offset[1],
-- 				-(self.offset[2] + ((self.spacing + self.size) * shown))
-- 			)
-- 			shown = shown + 1
-- 		end
-- 	end
-- end

-- function teleports:updateButton(mapId)
-- 	local mapInfo = mapInfoMap[mapId]
-- 	if not mapInfo then
-- 		return
-- 	end

-- 	local button = self.cache[mapId]
-- 	if not button then
-- 		return
-- 	end

-- 	local start, duration = GetSpellCooldown(mapInfo.spellId)
-- 	if duration > 0 then
-- 		button.cd:SetCooldown(start, duration)
-- 	else
-- 		button.cd:SetCooldown(0, 0)
-- 	end
-- end

-- function teleports:update()
-- 	for _, mapId in ipairs(cm.GetMapTable()) do
-- 		self:updateButton(mapId)
-- 	end
-- end

-- local f = CreateFrame 'Frame'
-- f:RegisterEvent 'ADDON_LOADED'
-- f:RegisterEvent 'CHALLENGE_MODE_COMPLETED'
-- f:RegisterEvent 'SPELL_UPDATE_COOLDOWN'
-- f:SetScript('OnEvent', function(self, event, ...)
-- 	if event == 'ADDON_LOADED' then
-- 		local addonName = ...
-- 		if addonName == 'Blizzard_ChallengesUI' then
-- 			-- teleports:init()
-- 			-- teleports:update()
-- 			hooksecurefunc(ChallengesFrame, 'Update', function()
-- 				teleports:OnUpdate()
-- 			end)
-- 		end
-- 	end

-- 	-- if event == 'CHALLENGE_MODE_COMPLETED' then
-- 	-- 	teleports:update()
-- 	-- end

-- 	-- if event == 'SPELL_UPDATE_COOLDOWN' and not InCombatLockdown() then
-- 	-- 	teleports:update()
-- 	-- end
-- end)
