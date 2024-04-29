local ns = select(2, ...)

ns.core.unitframes.elements.pvp = function(self, unit)
	local icon = self:CreateTexture(nil, 'ARTWORK', nil, 1)
	icon:SetSize(42, 42)

	local badge = self:CreateTexture(nil, 'ARTWORK')
	badge:SetSize(50, 52)
	badge:SetPoint('CENTER', PvPIndicator, 'CENTER')

	icon.Badge = badge
	self.PvPIndicator = icon
	return icon
end
