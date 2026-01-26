local _, ns = ...

local h = ns.helpers
local m = ns.media

local defaultBarColor = { 35 / 255, 35 / 255, 35 / 255 }

ns.unitframes.elements.powerbar = function(f, options)
	local o = options or {}

	local bd, bg = h.createBackdrop(f)
	local defaultBgColor = bg:GetVertexColor()

	local bar = CreateFrame('StatusBar', nil, bd)
	bar:SetStatusBarTexture(m.statusbars.default.file)
	bar:SetStatusBarColor(unpack(defaultBarColor))
	bar:SetPoint('TOPLEFT', 1, -1)
	bar:SetPoint('BOTTOMRIGHT', -1, 1)

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

		local color = PowerBarColor[displayType]
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
