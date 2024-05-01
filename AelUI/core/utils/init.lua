local ns = select(2, ...)

ns.utils = {}

local m = ns.media

ns.utils.AddBackdrop = function(frame)
	local bg = frame:CreateTexture(nil, 'BORDER')
	bg:SetTexture(m.backgrounds.default.file)
	bg:SetVertexColor(50 / 255, 50 / 255, 50 / 255)
	bg:SetPoint('TOPLEFT', 0, 0)
	bg:SetPoint('BOTTOMRIGHT', 0, 0)
end
