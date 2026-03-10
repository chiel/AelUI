local _, ns = ...

local BUTTON_SIZE = 36
local BUTTON_SPACING = 4
local NUM_BUTTONS = 12

local function createBar(name, buttonPrefix)
	local bar = CreateFrame('Frame', name, AelUIParent)
	local count = 0

	for i = 1, NUM_BUTTONS do
		local btn = _G[buttonPrefix .. i]
		if not btn then break end
		btn:SetSize(BUTTON_SIZE, BUTTON_SIZE)
		btn:ClearAllPoints()
		btn:SetParent(bar)

		if i == 1 then
			btn:SetPoint('LEFT', bar, 'LEFT', 0, 0)
		else
			btn:SetPoint('LEFT', _G[buttonPrefix .. (i - 1)], 'RIGHT', BUTTON_SPACING, 0)
		end

		count = count + 1
	end

	bar:SetSize(
		count * BUTTON_SIZE + (count - 1) * BUTTON_SPACING,
		BUTTON_SIZE
	)

	return bar
end

local bar5 = createBar('AelUIActionBar5', 'MultiBarLeftButton')
bar5:SetPoint('BOTTOM', AelUIParent, 'BOTTOM', 0, 40)

local bar4 = createBar('AelUIActionBar4', 'MultiBarRightButton')
bar4:SetPoint('BOTTOM', bar5, 'TOP', 0, BUTTON_SPACING)

local bar3 = createBar('AelUIActionBar3', 'MultiBarBottomRightButton')
bar3:SetPoint('BOTTOM', bar4, 'TOP', 0, BUTTON_SPACING)

local bar2 = createBar('AelUIActionBar2', 'MultiBarBottomLeftButton')
bar2:SetPoint('BOTTOM', bar3, 'TOP', 0, BUTTON_SPACING)

local bar1 = createBar('AelUIActionBar1', 'ActionButton')
bar1:SetPoint('BOTTOM', bar2, 'TOP', 0, BUTTON_SPACING)

local stanceBar = createBar('AelUIStanceBar', 'StanceButton')
stanceBar:SetPoint('BOTTOM', bar1, 'TOP', 0, BUTTON_SPACING)
