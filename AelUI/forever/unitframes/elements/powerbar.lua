local _, ns = ...

local u = ns.utils

ns.unitframes.elements.powerbar = function(f, options)
	local o = options or {}

	local bar, bd, bg, spark = u.createStatusBar(f, { spark = { overflow = 10 } })

	local function update(self)
		local powerType = UnitPowerType(self.unit)
		local displayType = o.powerType ~= nil and o.powerType or powerType
		local pct = UnitPowerPercent(self.unit, powerType, false, CurveConstants.ZeroToOne)

		bar:SetMinMaxValues(0, 1)
		bar:SetValue(pct)
		spark:Show()

		local color = ns.colors.power[displayType] or PowerBarColor[displayType]
		if color then
			bar:SetStatusBarColor(color.r, color.g, color.b)
		end
	end

	f:RegisterCallback('UNIT_POWER_UPDATE', update)
	f:RegisterCallback('UNIT_POWER_FREQUENT', update)
	f:RegisterCallback('UNIT_MAXPOWER', update)
	f:RegisterCallback('UNIT_DISPLAYPOWER', update)

	update(f)

	return bd
end
