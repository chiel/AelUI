local _, ns = ...

local m = ns.media
local u = ns.utils

ns.fishing.helpers.createButton = function(name, size, parent)
	local btn = CreateFrame('Button', name, parent, 'SecureActionButtonTemplate')
	btn:RegisterForClicks('LeftButtonDown')
	btn:SetSize(size, size)

	local bd, bg = u.createBackdrop(btn, { borderSize = 2 })
	bd:SetFrameLevel(btn:GetFrameLevel() - 1)
	bd:SetAllPoints()

	btn.texture = btn:CreateTexture(nil, 'ARTWORK')
	btn.texture:SetPoint('TOPLEFT', 2, -2)
	btn.texture:SetPoint('BOTTOMRIGHT', -2, 2)
	btn.texture:SetTexture(134400)

	btn.stacks = btn:CreateFontString(nil, 'OVERLAY')
	btn.stacks:SetFont(m.fonts.bold.file, 16, 'OUTLINE')
	btn.stacks:SetPoint('TOPRIGHT', btn, 'TOPRIGHT', 0, -1)
	btn.stacks:SetJustifyH('RIGHT')

	return btn
end
