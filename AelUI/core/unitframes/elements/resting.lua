local ns = select(2, ...)

ns.core.unitframes.elements.resting = function(self, unit)
	local icon = self:CreateTexture(nil, 'OVERLAY')
	icon:SetSize(20, 20)

	self.RestingIndicator = icon
	return icon
end
