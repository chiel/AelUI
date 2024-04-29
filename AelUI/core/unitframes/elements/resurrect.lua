local ns = select(2, ...)

ns.core.unitframes.elements.resurrect = function(self, unit)
	local resurrect = self:CreateTexture(nil, 'OVERLAY')
	resurrect:SetSize(16, 16)

	self.ResurrectIndicator = resurrect
	return resurrect
end
