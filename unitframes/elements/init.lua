local addon = select(2, ...)

addon.elements = {}

local defaultBgColor = { 50 / 255, 50 / 255, 50 / 255 }

function addon.elements.Backdrop(parent, color)
	local bd = CreateFrame('Frame', nil, parent, 'BackdropTemplate')
	bd:SetBackdrop { edgeFile = addon.media.border, edgeSize = 1 }
	bd:SetBackdropBorderColor(0, 0, 0, 1)

	local bg = bd:CreateTexture(nil, 'BORDER')
	bg:SetTexture(addon.media.textureBg)
	bg:SetVertexColor(unpack(color or defaultBgColor))
	bg:SetPoint('TOPLEFT', 1, -1)
	bg:SetPoint('BOTTOMRIGHT', -1, 1)
	bd.background = bg

	return bd
end
