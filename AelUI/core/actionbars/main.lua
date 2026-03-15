local _, ns = ...

local h = ns.helpers

local BUTTON_SIZE = 54
local BUTTON_SPACING = 4

ns.actionbars = {}

local function styleButton(btn)
	h.styleIcon(btn)
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
consumablesBar:SetPoint('BOTTOM', AelUIParent, 'BOTTOM', 0, 16)
ns.actionbars.consumablesBar = consumablesBar
