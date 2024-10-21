local ns = select(2, ...)

ns.unitframes.elements.raidMarker = function(self, unit)
	local raidMarker = self:CreateTexture(nil, 'OVERLAY')
	raidMarker:SetSize(16, 16)

	self.RaidTargetIndicator = raidMarker
	return raidMarker
end
