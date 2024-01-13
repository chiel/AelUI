local addon = select(2, ...)

addon.core.unitframes.elements.masterlooter = function(self, unit)
	local icon = self:CreateTexture(nil, 'OVERLAY')
	icon:SetSize(16, 16)

	self.MasterLooterIndicator = icon
	return icon
end
