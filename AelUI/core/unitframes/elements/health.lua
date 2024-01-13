local addon = select(2, ...)

local m = addon.core.media
local ce = addon.core.unitframes.elements

addon.core.unitframes.elements.health = function(self, unit)
	local backdrop, background = ce.backdrop(self)

	local health = CreateFrame('StatusBar', nil, backdrop)
	health:SetStatusBarTexture(m.statusbars.default.file)
	health.colorTapping = unit ~= 'raid'
	health.colorDisconnected = true
	health.colorClass = true
	health.colorReaction = true
	health:SetPoint('TOPLEFT', 1, -1)
	health:SetPoint('BOTTOMRIGHT', -1, 1)

	background:SetPoint('TOPLEFT', health:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)

	health.PostUpdateColor = function(element, unit, r, g, b)
		element:SetStatusBarColor(38 / 255, 38 / 255, 38 / 255)
		if not b then
			return
		end

		background:SetVertexColor(r * 0.75, g * 0.75, b * 0.75)

		if backdrop.PostUpdateColor then
			backdrop.PostUpdateColor(r, g, b)
		end
	end

	self.Health = health
	return backdrop
end
