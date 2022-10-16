local addon = select(2, ...)

local ufConfig = addon.config.unitframes
local round = addon.utils.Round
local size = round(ufConfig.height * 0.4)

function addon.elements.Leader(self, unit)
	local leader = self:CreateTexture(nil, 'OVERLAY')
	leader:SetSize(size, size)

	self.LeaderIndicator = leader
	return leader
end
