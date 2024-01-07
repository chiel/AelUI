local addon = select(2, ...)

local m = addon.core.media

addon.elements = {}

local defaultBgColor = { 50 / 255, 50 / 255, 50 / 255 }

function addon.elements.Backdrop(parent, color)
	local bd = CreateFrame('Frame', nil, parent, 'BackdropTemplate')
	bd:SetBackdrop({ edgeFile = m.borders.default.file, edgeSize = 1 })
	bd:SetBackdropBorderColor(0, 0, 0, 1)

	local bg = bd:CreateTexture(nil, 'BORDER')
	bg:SetTexture(m.backgrounds.default.file)
	bg:SetVertexColor(unpack(color or defaultBgColor))
	bg:SetPoint('TOPLEFT', 1, -1)
	bg:SetPoint('BOTTOMRIGHT', -1, 1)
	bd.background = bg

	return bd
end
