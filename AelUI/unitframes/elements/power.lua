local addon = select(2, ...)

function addon.elements.Power(self, unit)
	local backdrop = addon.elements.Backdrop(self)

	local power = CreateFrame('StatusBar', nil, backdrop)
	power:SetStatusBarTexture(addon.media.texture)
	power.colorPower = true
	power.frequentUpdates = true
	power:SetPoint('TOPLEFT', 1, -1)
	power:SetPoint('BOTTOMRIGHT', -1, 1)

	self.Power = power

	return backdrop
end
