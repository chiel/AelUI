local addon = select(2, ...)

local function CreateUpdateHealerPower(backdrop)
	return function(self, event, unit)
		if unit ~= self.unit then
			return
		end

		local role = UnitGroupRolesAssigned(self.unit)
		local visible = role == 'HEALER'

		if visible then
			self.Power:SetMinMaxValues(0, UnitPowerMax(unit, Enum.PowerType.Mana))
			self.Power:SetValue(UnitPower(unit, Enum.PowerType.Mana))
		end

		backdrop:SetShown(visible)
	end
end

function addon.elements.Power(self, unit, options)
	local options = options or {}
	local backdrop = addon.elements.Backdrop(self)

	local power = CreateFrame('StatusBar', nil, backdrop)
	power:SetStatusBarTexture(addon.media.texture)
	power.colorPower = true
	power.frequentUpdates = true
	power:SetPoint('TOPLEFT', 1, -1)
	power:SetPoint('BOTTOMRIGHT', -1, 1)

	if options.healerOnly then
		power.Override = CreateUpdateHealerPower(backdrop)
	end

	self.Power = power

	return backdrop
end
