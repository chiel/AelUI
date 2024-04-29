local ns = select(2, ...)

local m = ns.core.media
local ce = ns.core.unitframes.elements

ns.core.unitframes.elements.castbar = function(self, unit)
	if unit == 'player' then
		if CastingBarFrame then
			CastingBarFrame:UnregisterAllEvents()
		end

		PlayerCastingBarFrame:UnregisterAllEvents()
	end

	local castbar = CreateFrame('StatusBar', nil, self)
	local backdrop = ce.backdrop(castbar)
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
