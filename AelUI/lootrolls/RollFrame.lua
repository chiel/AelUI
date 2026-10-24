local _, ns = ...

local u = ns.utils
local m = ns.media

local FRAME_WIDTH = 500
local FRAME_HEIGHT = 40
local BAR_HEIGHT = 14
local BUTTON_SIZE = 28
local BUTTON_SPACING = 12

local frameIndex = 0

local RollFrame = {}

ns.lootrolls.createRollFrame = function(parent)
	frameIndex = frameIndex + 1
	local f = CreateFrame('Frame', 'AelUILootRoll' .. frameIndex, parent)
	f:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
	f:Hide()

	Mixin(f, RollFrame)
	f:Build()

	return f
end

local function createRollButton(parent, rollType, texture, yOffset)
	local button = CreateFrame('Button', nil, parent)
	button:SetSize(BUTTON_SIZE, BUTTON_SIZE)
	button:SetID(rollType)
	button.icon = button:CreateTexture(nil, 'ARTWORK')
	button.icon:SetTexture(texture)
	button.icon:SetPoint('TOPLEFT', 0, yOffset)
	button.icon:SetPoint('BOTTOMRIGHT', 0, yOffset)
	button.icon:SetAlpha(0.8)
	return button
end

function RollFrame:Build()
	local icon = u.createBackdrop(self)
	icon:SetSize(FRAME_HEIGHT, FRAME_HEIGHT)
	icon:SetPoint('LEFT')
	icon:EnableMouse(true)
	icon.texture = icon:CreateTexture(nil, 'ARTWORK')
	icon.texture:SetPoint('TOPLEFT', 1, -1)
	icon.texture:SetPoint('BOTTOMRIGHT', -1, 1)
	icon.stacks = icon:CreateFontString(nil, 'OVERLAY')
	icon.stacks:SetFont(m.fonts.bold.file, 14, 'OUTLINE')
	icon.stacks:SetPoint('TOPRIGHT', 4, 1)
	self.icon = icon

	local bar, barBd, barBg = u.createStatusBar(self)
	barBd:SetPoint('BOTTOMLEFT', icon, 'BOTTOMRIGHT', 2, 0)
	barBd:SetPoint('BOTTOMRIGHT')
	barBd:SetHeight(BAR_HEIGHT)
	bar:SetMinMaxValues(0, 1)
	bar:SetValue(1)
	barBd.bar = bar
	barBd.bg = barBg
	self.barBd = barBd

	self.passBtn = createRollButton(self, 0, [[Interface\RAIDFRAME\ReadyCheck-NotReady]], -2)
	self.greedBtn = createRollButton(self, 2, [[Interface\Buttons\UI-GroupLoot-Coin-Up]], -5)
	self.needBtn = createRollButton(self, 1, [[Interface\Buttons\UI-GroupLoot-Dice-Up]], -3)
	self.passBtn:SetPoint('BOTTOMRIGHT', barBd, 'TOPRIGHT', -2, 0)
	self.greedBtn:SetPoint('RIGHT', self.passBtn, 'LEFT', -BUTTON_SPACING, 0)
	self.needBtn:SetPoint('RIGHT', self.greedBtn, 'LEFT', -BUTTON_SPACING, 0)

	self.bind = self:CreateFontString(nil, 'OVERLAY')
	self.bind:SetFont(m.fonts.bold.file, 14, 'OUTLINE')
	self.bind:SetTextColor(0.8, 0.6, 0.6)
	self.bind:SetPoint('RIGHT', self.needBtn, 'LEFT', -6, -4)

	self.name = self:CreateFontString(nil, 'OVERLAY')
	self.name:SetFont(m.fonts.default.file, 18, 'OUTLINE')
	self.name:SetTextColor(1, 1, 1)
	self.name:SetJustifyH('LEFT')
	self.name:SetPoint('BOTTOMLEFT', barBd, 'TOPLEFT', 2, 2)
	self.name:SetPoint('RIGHT', self.bind, 'LEFT', -6, 0)
end

function RollFrame:ApplyRoll(roll)
	self.roll = roll
	self.rollID = roll.rollID

	self.icon.texture:SetTexture(roll.texture)
	self.icon.stacks:SetText(roll.count and roll.count > 1 and roll.count or '')
	self.name:SetText(roll.name)
	self.bind:SetText(roll.bindOnPickUp and 'BoP' or 'BoE')

	local color = ITEM_QUALITY_COLORS[roll.quality or 1] or ITEM_QUALITY_COLORS[1]
	self.barBd.bar:SetStatusBarColor(color.r * 0.6, color.g * 0.6, color.b * 0.6)
	self.barBd.bg:SetVertexColor(color.r * 0.15, color.g * 0.15, color.b * 0.15)
	self.barBd.bar:SetTimerDuration(roll.duration, nil, Enum.StatusBarTimerDirection.RemainingTime)

	local canNeed = roll.canNeed ~= false
	self.needBtn:SetEnabled(canNeed)
	self.needBtn:SetAlpha(canNeed and 1 or 0.3)
	local canGreed = roll.canTransmog or roll.canGreed ~= false
	self.greedBtn:SetEnabled(canGreed)
	self.greedBtn:SetAlpha(canGreed and 1 or 0.3)
	self.greedBtn:SetID(roll.canTransmog and 4 or 2)
	if roll.canTransmog then
		self.greedBtn.icon:SetAtlas('lootroll-toast-icon-transmog-up')
	else
		self.greedBtn.icon:SetTexture([[Interface\Buttons\UI-GroupLoot-Coin-Up]])
	end
end
