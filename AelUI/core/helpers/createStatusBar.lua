local _, ns = ...

local h = ns.helpers
local m = ns.media

ns.helpers.createStatusBar = function(parent)
	local bd, bg = h.createBackdrop(parent)

	local bar = CreateFrame('StatusBar', nil, bd)
	bar:SetStatusBarTexture(m.statusbars.default.file)
	bar:SetPoint('TOPLEFT', 1, -1)
	bar:SetPoint('BOTTOMRIGHT', -1, 1)

	bg:ClearAllPoints()
	bg:SetPoint('TOPLEFT', bar:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
	bg:SetPoint('BOTTOMRIGHT', bd, 'BOTTOMRIGHT', -1, 1)

	return bar, bd, bg
end
