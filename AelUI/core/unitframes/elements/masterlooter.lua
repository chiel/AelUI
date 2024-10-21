local ns = select(2, ...)

ns.unitframes.elements.masterlooter = function(self, unit)
	local icon = self:CreateTexture(nil, 'OVERLAY')
	icon:SetSize(16, 16)

	self.MasterLooterIndicator = icon
	return icon
end
