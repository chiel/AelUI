local _, ns = ...

local h = ns.helpers
local m = ns.media

local BUTTON_SIZE = 54
local BUTTON_SPACING = 4

ns.actionbars = {}

local function styleButton(btn)
	local name = btn:GetName()

	h.styleIcon(btn, { inset = 2 })

	-- strip extra action button textures
	if btn.Border then btn.Border:SetTexture(nil) end
	if btn.NewActionTexture then btn.NewActionTexture:SetTexture(nil) end
	if btn.FloatingBG then btn.FloatingBG:SetTexture(nil) end
	if btn.SlotBackground then btn.SlotBackground:Hide() end
	if btn.IconMask then btn.IconMask:Hide() end

	local flash = btn.Flash or _G[name .. 'Flash']
	if flash then flash:SetTexture(nil) end

	-- the global NormalTexture (no dot = child named without separator)
	local nt = _G[name .. 'NormalTexture']
	if nt then nt:SetTexture(nil) end

	-- hide hotkey text
	local hotkey = btn.HotKey or _G[name .. 'HotKey']
	if hotkey then hotkey:Hide() end

	-- hide macro name text
	local macroName = btn.Name or _G[name .. 'Name']
	if macroName then macroName:Hide() end

	-- restyle count text
	local count = btn.Count or _G[name .. 'Count']
	if count then
		count:SetParent(btn.bd)
		count:SetFont(m.fonts.bold.file, 16, 'OUTLINE')
		count:ClearAllPoints()
		count:SetPoint('TOPRIGHT', btn, 'TOPRIGHT', 0, -1)
		count:SetJustifyH('RIGHT')
	end

	-- hide cooldown countdown numbers
	local cd = btn.cooldown or btn.Cooldown or _G[name .. 'Cooldown']
	if cd and cd.SetHideCountdownNumbers then
		cd:SetHideCountdownNumbers(true)
	end

	-- custom cooldown text
	local icon = btn.icon or btn.Icon
	local cdText = btn.bd:CreateFontString(nil, 'OVERLAY')
	cdText:SetFont(m.fonts.bold.file, 16, 'OUTLINE')
	cdText:SetPoint('BOTTOM', btn, 'BOTTOM', 0, 0)
	cdText:SetJustifyH('CENTER')
	cdText:Hide()

	btn:HookScript('OnUpdate', function(self)
		if not self.action or not HasAction(self.action) then
			cdText:Hide()
			if icon then icon:SetDesaturated(false) end
			return
		end

		local start, duration = GetActionCooldown(self.action)
		if not start or start == 0 or duration <= 1.5 then
			cdText:Hide()
			if icon then icon:SetDesaturated(false) end
			return
		end

		local remaining = start + duration - GetTime()
		if remaining <= 0 then
			cdText:Hide()
			if icon then icon:SetDesaturated(false) end
			return
		end

		if icon then icon:SetDesaturated(true) end

		if remaining >= 3600 then
			cdText:SetText(math.floor(remaining / 3600) .. 'h')
		elseif remaining >= 300 then
			cdText:SetText(math.floor(remaining / 60) .. 'm')
		else
			cdText:SetText(string.format('%d:%02d', math.floor(remaining / 60), math.floor(remaining % 60)))
		end
		cdText:Show()
	end)
end

local function createBar(name, buttonPrefix, numButtons)
	local bar = CreateFrame('Frame', name, AelUIParent)

	for i = 1, (numButtons or 12) do
		local btn = _G[buttonPrefix .. i]
		if not btn then break end

		btn:SetSize(BUTTON_SIZE, BUTTON_SIZE)
		btn:ClearAllPoints()
		btn:SetParent(bar)
		styleButton(btn)

		if i == 1 then
			btn:SetPoint('LEFT', bar, 'LEFT', 0, 0)
		else
			btn:SetPoint('LEFT', _G[buttonPrefix .. (i - 1)], 'RIGHT', BUTTON_SPACING, 0)
		end
	end

	local count = numButtons or 12
	bar:SetSize(count * BUTTON_SIZE + (count - 1) * BUTTON_SPACING, BUTTON_SIZE)

	return bar
end

-- Remove from Blizzard's layout manager to prevent repositioning
if UIPARENT_MANAGED_FRAME_POSITIONS then
	UIPARENT_MANAGED_FRAME_POSITIONS.MultiBarLeft = nil
end

-- Hide the Blizzard container
MultiBarLeft:SetParent(CreateFrame('Frame'))
MultiBarLeft:UnregisterAllEvents()
MultiBarLeft:Hide()

-- Consumables bar (MultiBarLeft buttons, reparented into our own frame)
local consumablesBar = createBar('AelUIConsumablesBar', 'MultiBarLeftButton')
consumablesBar:SetPoint('BOTTOM', AelUIParent, 'BOTTOM', 0, 72)
