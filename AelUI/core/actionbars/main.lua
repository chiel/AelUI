local _, ns = ...

local h = ns.helpers

local BUTTON_SIZE_LARGE = 54
local BUTTON_SIZE_SMALL = 40
local BUTTON_SPACING = 4

ns.actionbars = {}

local function styleButton(btn)
	h.styleIcon(btn)
end

local function createBar(name, buttonPrefix, opts)
	local numButtons = opts and opts.numButtons or 12
	local buttonSize = opts and opts.buttonSize or BUTTON_SIZE_LARGE
	local bar = CreateFrame('Frame', name, AelUIParent)

	for i = 1, numButtons do
		local btn = _G[buttonPrefix .. i]
		if not btn then break end

		btn:SetSize(buttonSize, buttonSize)
		btn:ClearAllPoints()
		btn:SetParent(bar)
		styleButton(btn)

		if i == 1 then
			btn:SetPoint('LEFT', bar, 'LEFT', 0, 0)
		else
			btn:SetPoint('LEFT', _G[buttonPrefix .. (i - 1)], 'RIGHT', BUTTON_SPACING, 0)
		end
	end

	bar:SetSize(numButtons * buttonSize + (numButtons - 1) * BUTTON_SPACING, buttonSize)

	return bar
end

-- Remove from Blizzard's layout manager to prevent repositioning
if UIPARENT_MANAGED_FRAME_POSITIONS then
	UIPARENT_MANAGED_FRAME_POSITIONS.MultiBarLeft = nil
	UIPARENT_MANAGED_FRAME_POSITIONS.MultiBarBottomLeft = nil
	UIPARENT_MANAGED_FRAME_POSITIONS.MultiBarBottomRight = nil
	UIPARENT_MANAGED_FRAME_POSITIONS.MultiBarRight = nil
	UIPARENT_MANAGED_FRAME_POSITIONS.MainMenuBar = nil
end

-- Hide Blizzard containers
local hidden = CreateFrame('Frame')

local function hideBlizzardBar(bar)
	bar:SetParent(hidden)
	bar:UnregisterAllEvents()
	bar:Hide()
end

hideBlizzardBar(MultiBarLeft)
hideBlizzardBar(MultiBarBottomLeft)
hideBlizzardBar(MultiBarBottomRight)
hideBlizzardBar(MultiBarRight)
hideBlizzardBar(MainMenuBar)

if MainMenuBarArtFrame then MainMenuBarArtFrame:Hide() end
if MainMenuExpBar then MainMenuExpBar:Hide() end
if ReputationWatchBar then ReputationWatchBar:Hide() end

local BAR_SPACING = 4

-- Consumables bar (MultiBarLeft buttons, reparented into our own frame)
local consumablesBar = createBar('AelUIConsumablesBar', 'MultiBarLeftButton')
consumablesBar:SetPoint('BOTTOM', AelUIParent, 'BOTTOM', 0, 16)
ns.actionbars.consumablesBar = consumablesBar

-- MultiBarRight (just above consumables)
local rightBar = createBar('AelUIRightBar', 'MultiBarRightButton', { buttonSize = BUTTON_SIZE_SMALL })
rightBar:SetPoint('BOTTOM', consumablesBar, 'TOP', 0, BAR_SPACING)
ns.actionbars.rightBar = rightBar

-- Bar 3 (MultiBarBottomRight)
local bar3 = createBar('AelUIActionBar3', 'MultiBarBottomRightButton', { buttonSize = BUTTON_SIZE_SMALL })
bar3:SetPoint('BOTTOM', rightBar, 'TOP', 0, BAR_SPACING)
ns.actionbars.bar3 = bar3

-- Bar 2 (MultiBarBottomLeft)
local bar2 = createBar('AelUIActionBar2', 'MultiBarBottomLeftButton', { buttonSize = BUTTON_SIZE_SMALL })
bar2:SetPoint('BOTTOM', bar3, 'TOP', 0, BAR_SPACING)
ns.actionbars.bar2 = bar2

-- Bar 1 (Main action bar)
local bar1 = createBar('AelUIActionBar1', 'ActionButton', { buttonSize = BUTTON_SIZE_SMALL })
bar1:SetPoint('BOTTOM', bar2, 'TOP', 0, BAR_SPACING)
ns.actionbars.bar1 = bar1
