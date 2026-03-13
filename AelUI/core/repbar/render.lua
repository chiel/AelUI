local _, ns = ...

local h = ns.helpers
local m = ns.media

local bar, bd, bg = h.createStatusBar(AelUIParent, { spark = { overflow = 12 } })
bd:SetSize(500, 18)
bd:SetPoint('BOTTOM', AelUIParent, 'BOTTOM', 0, 38)

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

ns.repbar.render = function(state)
	if not state then
		bd:Hide()
		return
	elseif not bd:IsShown() then
		bd:Show()
	end

	bar:SetMinMaxValues(0, state.max)
	bar:SetValue(state.current)

	local c = state.color
	bar:SetStatusBarColor(c.r, c.g, c.b)

	local standingLabel = GetText('FACTION_STANDING_LABEL' .. state.reaction, UnitSex('player'))
	local pct = state.max > 0 and (state.current / state.max * 100) or 0
	text:SetText(string.format('%s: %s  %d / %d (%.1f%%)', state.name, standingLabel, state.current, state.max, pct))
end
