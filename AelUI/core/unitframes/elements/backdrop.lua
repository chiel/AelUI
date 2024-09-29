local _, ns = ...

local m = ns.media

local defaultBgColor = { 50 / 255, 50 / 255, 50 / 255 }

ns.unitframes.elements.backdrop = function(self)
	local bd = CreateFrame('Frame', nil, self, 'BackdropTemplate')
	bd:SetBackdrop({ edgeFile = m.borders.default.file, edgeSize = 1 })
	bd:SetBackdropBorderColor(0, 0, 0, 1)

	local bg = bd:CreateTexture(nil, 'BORDER')
	bg:SetTexture(m.backgrounds.default.file)
	bg:SetVertexColor(unpack(defaultBgColor))
	bg:SetPoint('TOPLEFT', 1, -1)
	bg:SetPoint('BOTTOMRIGHT', -1, 1)

	return bd, bg
end
