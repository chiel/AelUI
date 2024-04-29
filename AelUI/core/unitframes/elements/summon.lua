local ns = select(2, ...)

ns.core.unitframes.elements.summon = function(self, unit)
	local summon = self:CreateTexture(nil, 'OVERLAY')
	summon:SetSize(24, 24)

	self.SummonIndicator = summon
	return summon
end
