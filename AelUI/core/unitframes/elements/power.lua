local ns = select(2, ...)

local m = ns.media
local ce = ns.unitframes.elements

-- local function CreateUpdateHealerPower(backdrop)
-- 	return function(self, event, unit)
-- 		if unit ~= self.unit then
-- 			return
-- 		end

-- 		local role = UnitGroupRolesAssigned(self.unit)
-- 		local visible = role == 'HEALER'

-- 		if visible then
-- 			self.Power:SetMinMaxValues(0, UnitPowerMax(unit, Enum.PowerType.Mana))
-- 			self.Power:SetValue(UnitPower(unit, Enum.PowerType.Mana))
-- 		end

-- 		backdrop:SetShown(visible)
-- 	end
-- end

ns.unitframes.elements.power = function(self, unit, options)
	-- local o = options or {}
	local backdrop = ce.backdrop(self)

	local power = CreateFrame('StatusBar', nil, backdrop)
	power:SetStatusBarTexture(m.statusbars.default.file)
	power.colorPower = true
	power.frequentUpdates = true
	power:SetPoint('TOPLEFT', 1, -1)
	power:SetPoint('BOTTOMRIGHT', -1, 1)
	ns.utils.setSmoothing(power, true)

	-- if o.healerOnly then
	-- 	power.Override = CreateUpdateHealerPower(backdrop)
	-- end

	self.Power = power
	return backdrop
end
