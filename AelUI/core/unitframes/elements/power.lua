local _, ns = ...

local m = ns.media
local e = ns.unitframes.elements

ns.unitframes.elements.power = function(self, unit)
	local backdrop = e.backdrop(self)

	local power = CreateFrame('StatusBar', nil, backdrop)
	power:SetStatusBarTexture(m.statusbars.default.file)
	power.colorPower = true
	power.frequentUpdates = true
	power:SetPoint('TOPLEFT', 1, -1)
	power:SetPoint('BOTTOMRIGHT', -1, 1)

	self.Power = power
	return backdrop
end
