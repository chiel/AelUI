local ns = select(2, ...)

ns.core.unitframes.elements.leader = function(self, unit)
	local icon = self:CreateTexture(nil, 'OVERLAY')
	icon:SetSize(16, 16)

	self.LeaderIndicator = icon
	return icon
end
