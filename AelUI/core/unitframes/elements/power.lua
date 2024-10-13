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
	ns.utils.setSmoothing(power, true)

	local spark = power:CreateTexture(nil, 'OVERLAY')
	spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])
	spark:SetSize(10, 30)
	spark:SetBlendMode('ADD')
	spark:SetPoint('CENTER', power:GetStatusBarTexture(), 'RIGHT', 0, 0)

	power.PostUpdate = function(self, unit, cur, min, max)
		if min == nil then
			min = 0
		end

		if cur == min or cur == max then
			spark:Hide()
		else
			spark:Show()
		end
	end

	self.Power = power
	return backdrop
end
