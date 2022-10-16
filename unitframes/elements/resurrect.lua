local addon = select(2, ...)

local ufConfig = addon.config.unitframes
local round = addon.utils.Round
local size = round(ufConfig.height * 0.8)

function addon.elements.Resurrect(self, unit)
	local resurrect = self:CreateTexture(nil, 'OVERLAY')
	resurrect:SetSize(size, size)

	self.ResurrectIndicator = resurrect
	return resurrect
end
