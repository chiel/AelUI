local addon = select(2, ...)

function addon.elements.Resurrect(self, unit)
	local resurrect = self:CreateTexture(nil, 'OVERLAY')
	resurrect:SetSize(32, 32)

	self.ResurrectIndicator = resurrect
	return resurrect
end
