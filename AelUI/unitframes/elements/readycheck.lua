local addon = select(2, ...)

local ufConfig = addon.config.unitframes
local round = addon.utils.Round
local size = round(ufConfig.height * 0.6)

function addon.elements.ReadyCheck(self, unit)
	local readyCheck = self:CreateTexture(nil, 'OVERLAY')
	readyCheck:SetSize(size, size)

	self.ReadyCheckIndicator = readyCheck
	return readyCheck
end
