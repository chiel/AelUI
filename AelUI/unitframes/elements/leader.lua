local addon = select(2, ...)

local ufConfig = addon.core.config.unitframes
local round = addon.core.utils.round

local size = round(ufConfig.height * 0.4)

function addon.elements.Leader(self, unit)
	local leader = self:CreateTexture(nil, 'OVERLAY')
	leader:SetSize(size, size)

	self.LeaderIndicator = leader
	return leader
end
