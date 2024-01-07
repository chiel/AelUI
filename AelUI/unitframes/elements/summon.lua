local addon = select(2, ...)

local ufConfig = addon.core.config.unitframes
local round = addon.core.utils.round

local size = round(ufConfig.height * 0.8)

function addon.elements.Summon(self, unit)
	local summon = self:CreateTexture(nil, 'OVERLAY')
	summon:SetSize(size, size)

	self.SummonIndicator = summon
	return summon
end
