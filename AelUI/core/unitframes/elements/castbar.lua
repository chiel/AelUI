local _, ns = ...

local e = ns.unitframes.elements
local m = ns.media

ns.unitframes.elements.castbar = function(self, unit)
	local castbar = CreateFrame('StatusBar', nil, self)
	local backdrop = e.backdrop(castbar)
	backdrop:SetFrameLevel(castbar:GetFrameLevel() - 1)

	castbar:SetStatusBarTexture(m.statusbars.default.file)
	castbar:SetStatusBarColor(32 / 255, 32 / 255, 32 / 255)
	castbar:SetPoint('TOPLEFT', backdrop, 1, -1)
	castbar:SetPoint('BOTTOMRIGHT', backdrop, -1, 1)

	local Spark = castbar:CreateTexture(nil, 'OVERLAY')
	Spark:SetSize(10, 30)
	Spark:SetBlendMode('ADD')
	Spark:SetPoint('CENTER', castbar:GetStatusBarTexture(), 'RIGHT', 0, 0)

	castbar.Spark = Spark
	self.Castbar = castbar
	return backdrop
end
