local addon = select(2, ...)

local ufConfig = addon.core.config.unitframes
local round = addon.core.utils.round

local size = round(ufConfig.height * 0.6)

function addon.elements.ReadyCheck(self, unit)
	local readyCheck = self:CreateTexture(nil, 'OVERLAY')
	readyCheck:SetSize(size, size)

	self.ReadyCheckIndicator = readyCheck
	return readyCheck
end
