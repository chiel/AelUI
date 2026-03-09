local _, ns = ...

local m = ns.media

ns.helpers.createIcon = function(parent, size)
	local icon = CreateFrame('Frame', nil, parent, 'BackdropTemplate')
	icon:SetSize(size, size)
	icon:SetBackdrop({ edgeFile = m.borders.default.file, edgeSize = 1 })
	icon:SetBackdropBorderColor(0, 0, 0, 1)

	icon.texture = icon:CreateTexture(nil, 'ARTWORK')
	icon.texture:SetPoint('TOPLEFT', 1, -1)
	icon.texture:SetPoint('BOTTOMRIGHT', -1, 1)
	icon.texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)

	icon.cooldown = CreateFrame('Cooldown', nil, icon, 'CooldownFrameTemplate')
	icon.cooldown:SetAllPoints(icon.texture)
	icon.cooldown:SetDrawEdge(false)
	icon.cooldown:SetHideCountdownNumbers(true)
	icon.cooldown:SetReverse(true)

	icon.stacks = icon.cooldown:CreateFontString(nil, 'OVERLAY')
	icon.stacks:SetFont(m.fonts.bold.file, 14, 'OUTLINE')
	icon.stacks:SetPoint('TOPRIGHT', 4, 1)

	return icon
end
