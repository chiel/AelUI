local ns = select(2, ...)

ns.unitframes.elements.readyCheck = function(self, unit)
	local readyCheck = self:CreateTexture(nil, 'OVERLAY')
	readyCheck:SetSize(16, 16)

	self.ReadyCheckIndicator = readyCheck
	return readyCheck
end
