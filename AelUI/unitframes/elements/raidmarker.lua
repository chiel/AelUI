local addon = select(2, ...)

function addon.elements.RaidMarker(self, unit)
	local raidMarker = self:CreateTexture(nil, 'OVERLAY')
	raidMarker:SetSize(20, 20)

	self.RaidTargetIndicator = raidMarker
	return raidMarker
end
