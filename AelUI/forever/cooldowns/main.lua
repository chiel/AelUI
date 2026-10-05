local _, ns = ...

local u = ns.utils

local SHOOT_SPELL_ID = 5019
local ICON_SIZE = 58
local BORDER_COLOR = { 0, 0, 0, 1 }
local OUT_OF_RANGE_BORDER_COLOR = { 1, 0, 0, 1 }

local frame, background = u.createBackdrop(AelUIParent)
frame:SetSize(ICON_SIZE, ICON_SIZE)
frame:SetPoint('TOPLEFT', AelUIPrimaryAnchor, 0, 0)
frame:Hide()

local icon = frame:CreateTexture(nil, 'ARTWORK')
icon:SetPoint('TOPLEFT', frame, 'TOPLEFT', 1, -1)
icon:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', -1, 1)
icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

local activeIndicator = CreateFrame('Frame', nil, frame, 'BackdropTemplate')
activeIndicator:SetPoint('TOPLEFT', frame, 'TOPLEFT', 3, -3)
activeIndicator:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', -3, 3)
activeIndicator:SetFrameLevel(frame:GetFrameLevel() + 2)
activeIndicator:SetBackdrop({ edgeFile = ns.media.borders.default.file, edgeSize = 2 })
activeIndicator:SetBackdropBorderColor(1, 0.8, 0, 1)
activeIndicator:Hide()

local function setOutOfRange(outOfRange)
	local color = outOfRange and OUT_OF_RANGE_BORDER_COLOR or BORDER_COLOR
	frame:SetBackdropBorderColor(unpack(color))
end

local function updateIcon()
	icon:SetTexture(C_Spell.GetSpellTexture(SHOOT_SPELL_ID))
end

local function updateRange()
	local inRange = C_Spell.IsSpellInRange(SHOOT_SPELL_ID, 'target')
	setOutOfRange(not issecretvalue(inRange) and inRange == false)
end

local function updateRangeFromEvent(inRange, checkedRange)
	if issecretvalue(inRange) or issecretvalue(checkedRange) then
		setOutOfRange(false)
		return
	end

	setOutOfRange(checkedRange and inRange == false)
end

local function update()
	updateIcon()
	updateRange()
	frame:Show()
end

local function setActive(state)
	activeIndicator:SetShown(state)
end

frame:RegisterEvent('PLAYER_ENTERING_WORLD')
frame:RegisterEvent('SPELLS_CHANGED')
frame:RegisterEvent('SPELL_RANGE_CHECK_UPDATE')
frame:RegisterEvent('START_AUTOREPEAT_SPELL')
frame:RegisterEvent('STOP_AUTOREPEAT_SPELL')
frame:SetScript('OnEvent', function(_, event, spellID, isInRange, checkedRange)
	if event == 'SPELL_RANGE_CHECK_UPDATE' then
		if not issecretvalue(spellID) and spellID == SHOOT_SPELL_ID then
			updateRangeFromEvent(isInRange, checkedRange)
		end
		return
	end

	if event == 'START_AUTOREPEAT_SPELL' then
		setActive(true)
		return
	end

	if event == 'STOP_AUTOREPEAT_SPELL' then
		setActive(false)
		return
	end

	if event == 'PLAYER_ENTERING_WORLD' then
		C_Spell.EnableSpellRangeCheck(SHOOT_SPELL_ID, true)
	end

	update()
end)
