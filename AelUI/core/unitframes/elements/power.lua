local ns = select(2, ...)

local m = ns.media
local ce = ns.unitframes.elements

ns.unitframes.elements.power = function(self, unit)
	local backdrop = ce.backdrop(self)

	local power = CreateFrame('StatusBar', nil, backdrop)
	power:SetStatusBarTexture(m.statusbars.default.file)
	power.colorPower = true
	power.frequentUpdates = true
	power:SetPoint('TOPLEFT', 1, -1)
	power:SetPoint('BOTTOMRIGHT', -1, 1)
	ns.utils.setSmoothing(power, true)

	self.Power = power
	return backdrop
end
