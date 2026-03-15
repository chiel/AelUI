local _, ns = ...

local m = ns.media

local defaultBgColor = { 50 / 255, 50 / 255, 50 / 255 }

ns.helpers.createBackdrop = function(parent, options)
	local o = options or {}
	local borderSize = o.borderSize or 1

	local bd = CreateFrame('Frame', nil, parent, 'BackdropTemplate')
	bd:SetBackdrop({ edgeFile = m.borders.default.file, edgeSize = borderSize })
	bd:SetBackdropBorderColor(0, 0, 0, 1)

	local bg = bd:CreateTexture(nil, 'BORDER')
	bg:SetTexture(m.backgrounds.default.file)
	bg:SetVertexColor(unpack(defaultBgColor))
	bg:SetPoint('TOPLEFT', borderSize, -borderSize)
	bg:SetPoint('BOTTOMRIGHT', -borderSize, borderSize)

	return bd, bg
end
