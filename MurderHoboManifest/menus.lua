local _, MHM = ...

local modernMenuSetup = false

local function addPlayer(player)
	if not player then
		return
	end

	if not MHM:AddToPersonalManifest(player) then
		DEFAULT_CHAT_FRAME:AddMessage(string.format('MHM: %s is already on Grudge List.', MHM:FormatPlayer(player)))
	end
end

local function setupModernMenu()
	if modernMenuSetup then
		return true
	end

	if not Menu or not Menu.ModifyMenu then
		return false
	end

	local function registerMenu(tag)
		Menu.ModifyMenu(tag, function(_, rootDescription)
			rootDescription:QueueDivider()
			rootDescription:QueueTitle('Murder Hobo Manifest')
			rootDescription:CreateButton('Add to Grudge List', function()
				addPlayer(MHM:SnapshotPlayer('target'))
			end)
		end)
	end

	registerMenu('MENU_UNIT_ENEMY_PLAYER')
	registerMenu('MENU_UNIT_PLAYER')
	modernMenuSetup = true

	return true
end

local function setupLegacyMenu()
	if not UnitPopup_ShowMenu or not UIDropDownMenu_CreateInfo or not UIDropDownMenu_AddButton then
		return
	end

	hooksecurefunc('UnitPopup_ShowMenu', function(dropdownMenu, _, unit)
		unit = unit or dropdownMenu.unit
		local player = MHM:SnapshotPlayer(unit)
		if not player then
			return
		end

		local info = UIDropDownMenu_CreateInfo()
		info.text = 'Add to Grudge List'
		info.notCheckable = true
		info.func = function()
			addPlayer(player)
		end
		UIDropDownMenu_AddButton(info)
	end)
end

local frame = CreateFrame('Frame')
frame:RegisterEvent('PLAYER_LOGIN')
frame:RegisterEvent('ADDON_LOADED')
frame:SetScript('OnEvent', function(self, event)
	if event == 'PLAYER_LOGIN' then
		self:UnregisterEvent('PLAYER_LOGIN')

		if not setupModernMenu() then
			setupLegacyMenu()
		else
			self:UnregisterEvent('ADDON_LOADED')
		end
		return
	end

	if setupModernMenu() then
		self:UnregisterEvent('ADDON_LOADED')
	end
end)
