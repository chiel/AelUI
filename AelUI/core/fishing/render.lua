local _, ns = ...

local m = ns.media
local s = ns.fishing
local u = ns.utils

local FISHING_SPELL_ID = 7732
local ICON_SIZE = 58
local ICON_SPACING = 2

local container = CreateFrame('Frame', nil, AelUIParent)
container:SetPoint('BOTTOMRIGHT', ns.anchors.primary, 'TOPLEFT', -20, 80)
container:SetAlpha(0.75)
container:Hide()

local function createButton(name, parent)
	local btn = CreateFrame('Button', name, parent, 'SecureActionButtonTemplate')
	btn:SetSize(ICON_SIZE, ICON_SIZE)
	btn:RegisterForClicks('LeftButtonDown')

	local bd, bg = u.createBackdrop(btn, { borderSize = 2 })
	bd:SetAllPoints()
	bd:SetFrameLevel(math.max(btn:GetFrameLevel() - 1, 0))

	btn.texture = btn:CreateTexture(nil, 'ARTWORK')
	btn.texture:SetPoint('TOPLEFT', 2, -2)
	btn.texture:SetPoint('BOTTOMRIGHT', -2, 2)

	btn.stacks = btn:CreateFontString(nil, 'OVERLAY')
	btn.stacks:SetFont(m.fonts.bold.file, 16, 'OUTLINE')
	btn.stacks:SetPoint('TOPRIGHT', btn, 'TOPRIGHT', 0, -1)
	btn.stacks:SetJustifyH('RIGHT')

	return btn
end

local castBtn = createButton('AelUIFishingCast', container)
castBtn:SetPoint('RIGHT', container, 'RIGHT', 0, 0)
castBtn:SetAttribute('type', 'macro')
castBtn:SetAttribute('macrotext', '/cast Fishing')

local function updateCastIcon()
	local spell = C_Spell.GetSpellInfo(FISHING_SPELL_ID)
	if spell.iconID then
		castBtn.texture:SetTexture(spell.iconID)
		return true
	end
end

local lureButtons = {}

local function getLureButton(index)
	if lureButtons[index] then
		return lureButtons[index]
	end

	local btn = createButton('AelUIFishingLure' .. index, container)
	btn:SetAttribute('type', 'macro')

	btn.bonus = btn:CreateFontString(nil, 'OVERLAY')
	btn.bonus:SetFont(m.fonts.bold.file, 16, 'OUTLINE')
	btn.bonus:SetPoint('BOTTOM', btn, 'BOTTOM', 0, 1)

	lureButtons[index] = btn
	return btn
end

s.render = function(state)
	if not state.hasPole then
		container:Hide()
		return
	end

	updateCastIcon()
	container:Show()
	castBtn.texture:SetDesaturated(not state.hasEnchant)

	local lures = state.lures

	for i, lure in ipairs(lures) do
		local btn = getLureButton(i)
		btn:ClearAllPoints()
		btn:SetAttribute('macrotext', '/use ' .. lure.name .. '\n/use 16')
		btn.texture:SetTexture(lure.icon)
		btn.stacks:SetText(lure.count > 1 and lure.count or '')
		btn.bonus:SetText('+' .. lure.bonus)
		btn:SetPoint('RIGHT', container, 'RIGHT', -(ICON_SIZE + ICON_SPACING) * i, 0)
		btn:Show()
	end

	for i = #lures + 1, #lureButtons do
		lureButtons[i]:Hide()
	end

	local totalButtons = #lures + 1
	local totalWidth = (ICON_SIZE * totalButtons) + (ICON_SPACING * (totalButtons - 1))
	container:SetSize(totalWidth, ICON_SIZE)
end
