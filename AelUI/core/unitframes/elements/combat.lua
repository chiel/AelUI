local ns = select(2, ...)

ns.unitframes.elements.combat = function(self, unit)
	local icon = self:CreateTexture(nil, 'OVERLAY')
	icon:SetSize(24, 24)

	self.CombatIndicator = icon
	return icon
end
