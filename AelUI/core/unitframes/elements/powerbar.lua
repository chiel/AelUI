local _, ns = ...

local h = ns.helpers

ns.unitframes.elements.powerbar = function(f, options)
	local o = options or {}

	local bar, bd, bg = h.createStatusBar(f)

	local spark = bar:CreateTexture(nil, 'OVERLAY')
	spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])
	spark:SetBlendMode('ADD')
	spark:SetWidth(10)
	spark:SetSize(10, 30)
	spark:SetPoint('TOP', bar:GetStatusBarTexture(), 'TOPRIGHT', 0, 10)
	spark:SetPoint('BOTTOM', bar:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, -10)

	local function update(self)
		local powerType = UnitPowerType(self.unit)
		local displayType = o.powerType ~= nil and o.powerType or powerType
		local current = UnitPower(self.unit, displayType)
		local max = UnitPowerMax(self.unit, displayType)

		bar:SetMinMaxValues(0, max)
		bar:SetValue(current)
		spark:SetShown(current > 0 and current < max)

		local color = ns.colors.power[displayType] or PowerBarColor[displayType]
		if color then
			bar:SetStatusBarColor(color.r, color.g, color.b)
		end

		if o.onUpdate then
			o.onUpdate(bd, {
				current = current,
				max = max,
				displayType = displayType,
				powerType = powerType,
			})
		end
	end

	f:RegisterCallback('UNIT_POWER_UPDATE', update)
	f:RegisterCallback('UNIT_POWER_FREQUENT', update)
	f:RegisterCallback('UNIT_MAXPOWER', update)
	f:RegisterCallback('UNIT_DISPLAYPOWER', update)

	update(f)

	return bd
end
