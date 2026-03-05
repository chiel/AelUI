local _, ns = ...

local h = ns.helpers
local m = ns.media

ns.helpers.createStatusBar = function(parent, options)
	local o = options or {}

	local bd, bg = h.createBackdrop(parent)

	local bar = CreateFrame('StatusBar', nil, bd)
	bar:SetStatusBarTexture(m.statusbars.default.file)
	bar:SetPoint('TOPLEFT', 1, -1)
	bar:SetPoint('BOTTOMRIGHT', -1, 1)

	bg:ClearAllPoints()

	if o.orientation == 'VERTICAL' then
		bar:SetOrientation('VERTICAL')
		bg:SetPoint('TOPLEFT', bd, 'TOPLEFT', 1, -1)
		bg:SetPoint('BOTTOMRIGHT', bar:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
	else
		bg:SetPoint('TOPLEFT', bar:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
		bg:SetPoint('BOTTOMRIGHT', bd, 'BOTTOMRIGHT', -1, 1)
	end

	return bar, bd, bg
end
