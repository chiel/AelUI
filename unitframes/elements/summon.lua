local addon = select(2, ...)

function addon.elements.Summon(self, unit)
	local summon = self:CreateTexture(nil, 'OVERLAY')
	summon:SetSize(32, 32)

	self.SummonIndicator = summon
	return summon
end
