local _, ns = ...

local h = ns.helpers
local m = ns.media

local defaultBarColor = { 35 / 255, 35 / 255, 35 / 255 }

ns.unitframes.elements.powerbar = function(f)
	local bd, bg = h.createBackdrop(f)
	local defaultBgColor = bg:GetVertexColor()

	local bar = CreateFrame('StatusBar', nil, bd)
	bar:SetStatusBarTexture(m.statusbars.default.file)
	bar:SetStatusBarColor(unpack(defaultBarColor))
	bar:SetAllPoints()
	bar:SetPoint('TOPLEFT', 1, -1)
	bar:SetPoint('BOTTOMRIGHT', -1, 1)

	local function update(self, event, ...)
		local current = UnitPower(self.unit)
		local max = UnitPowerMax(self.unit)

		bar:SetMinMaxValues(0, max)
		bar:SetValue(current)

		local powerType = UnitPowerType(self.unit)
		local color = PowerBarColor[powerType]
		if color then
			bar:SetStatusBarColor(color.r, color.g, color.b)
		end
	end

	f:RegisterCallback('UNIT_POWER_UPDATE', update)
	f:RegisterCallback('UNIT_POWER_FREQUENT', update)
	f:RegisterCallback('UNIT_MAXPOWER', update)
	f:RegisterCallback('UNIT_DISPLAYPOWER', update)

	update(f, 'UNIT_POWER_UPDATE')

	return bd
end
