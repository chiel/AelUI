local ns = select(2, ...)

ns.core.utils = {}

local m = ns.core.media

ns.core.utils.AddBackdrop = function(frame)
	local bg = frame:CreateTexture(nil, 'BORDER')
	bg:SetTexture(m.backgrounds.default.file)
	bg:SetVertexColor(50 / 255, 50 / 255, 50 / 255)
	bg:SetPoint('TOPLEFT', 0, 0)
	bg:SetPoint('BOTTOMRIGHT', 0, 0)
end
