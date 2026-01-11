local _, ns = ...

local m = ns.media

local defaultBgColor = { 50 / 255, 50 / 255, 50 / 255 }

table.insert(ns.unitframes.units, {
	unit = 'player',
	style = function(f)
		f:SetPoint('TOPLEFT', AelUIParent, 'TOPLEFT', 30, -30)
		f:SetSize(280, 60)

		local bd = CreateFrame('Frame', nil, f, 'BackdropTemplate')
		bd:SetBackdrop({ edgeFile = m.borders.default.file, edgeSize = 1 })
		bd:SetBackdropBorderColor(0, 0, 0, 1)
		bd:SetAllPoints()

		local bg = bd:CreateTexture(nil, 'BORDER')
		bg:SetTexture(m.backgrounds.default.file)
		bg:SetVertexColor(unpack(defaultBgColor))
		bg:SetPoint('TOPLEFT', 1, -1)
		bg:SetPoint('BOTTOMRIGHT', -1, 1)

		return f
	end,
})
