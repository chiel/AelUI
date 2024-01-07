local addon = select(2, ...)

local ufConfig = addon.core.config.unitframes
local round = addon.core.utils.round
local size = round(ufConfig.height * 0.8)

function addon.elements.Resurrect(self, unit)
	local resurrect = self:CreateTexture(nil, 'OVERLAY')
	resurrect:SetSize(size, size)

	self.ResurrectIndicator = resurrect
	return resurrect
end
