local addon = select(2, ...)

function addon.elements.ReadyCheck(self, unit)
	local readyCheck = self:CreateTexture(nil, 'OVERLAY')
	readyCheck:SetSize(24, 24)

	self.ReadyCheckIndicator = readyCheck
	return readyCheck
end
