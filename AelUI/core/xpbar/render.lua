local _, ns = ...

local h = ns.helpers
local m = ns.media

local bar, bd, bg = h.createStatusBar(AelUIParent, { spark = { overflow = 12 } })
bd:SetSize(500, 18)
bd:SetPoint('BOTTOM', AelUIParent, 'BOTTOM', 0, 74)

local restedBar = CreateFrame('StatusBar', nil, bd)
restedBar:SetStatusBarTexture(m.statusbars.default.file)
restedBar:SetPoint('TOPLEFT', 1, -1)
restedBar:SetPoint('BOTTOMRIGHT', -1, 1)
restedBar:SetStatusBarColor(0.0, 0.39, 0.88, 0.25)
restedBar:SetFrameLevel(bar:GetFrameLevel() - 1)

local text = bar:CreateFontString(nil, 'OVERLAY')
text:SetFont(m.fonts.default.file, 18, 'OUTLINE')
text:SetPoint('CENTER', bd, 'CENTER', 0, 0)
text:Hide()

bd:EnableMouse(true)
bd:SetScript('OnEnter', function()
	text:Show()
end)
bd:SetScript('OnLeave', function()
	text:Hide()
end)

ns.xpbar.render = function(state)
	if state.isMaxLevel then
		bd:Hide()
		return
	elseif not bd:IsShown() then
		bd:Show()
	end

	bar:SetMinMaxValues(0, state.max)
	bar:SetValue(state.current)

	local isRested = state.exhaustion > 0
	if isRested then
		restedBar:SetMinMaxValues(0, state.max)
		restedBar:SetValue(math.min(state.current + state.exhaustion, state.max))
		restedBar:Show()
		bar:SetStatusBarColor(0.0, 0.39, 0.88)
	else
		restedBar:Hide()
		bar:SetStatusBarColor(0.58, 0.0, 0.55)
	end

	local pct = state.max > 0 and (state.current / state.max * 100) or 0
	local restedPct = state.max > 0 and (state.exhaustion / state.max * 100) or 0
	local restedStr = state.exhaustion > 0
			and string.format('  (+%s / %.0f%% rested)', AbbreviateNumbers(state.exhaustion), restedPct)
		or ''
	text:SetText(
		string.format(
			'%s / %s (%.1f%%)%s',
			AbbreviateNumbers(state.current),
			AbbreviateNumbers(state.max),
			pct,
			restedStr
		)
	)
end
