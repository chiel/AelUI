local addon = select(2, ...)

function addon.elements.Health(self, unit)
	local backdrop = addon.elements.Backdrop(self)

	local health = CreateFrame('StatusBar', nil, backdrop)
	health:SetStatusBarTexture(addon.media.texture)
	health.colorTapping = unit ~= 'raid'
	health.colorDisconnected = true
	health.colorClass = true
	health.colorReaction = true
	health:SetPoint('TOPLEFT', 1, -1)
	health:SetPoint('BOTTOMRIGHT', -1, 1)

	health.PostUpdateColor = function(element, unit, r, g, b)
		element:SetStatusBarColor(38 / 255, 38 / 255, 38 / 255)
		backdrop.background:SetVertexColor(r * 0.75, g * 0.75, b * 0.75)
	end

	self.Health = health
	return backdrop
end
