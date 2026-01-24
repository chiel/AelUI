local _, ns = ...

local h = ns.helpers
local m = ns.media

local defaultBarColor = { 35 / 255, 35 / 255, 35 / 255 }

ns.unitframes.elements.healthbar = function(f)
	local bd, bg = h.createBackdrop(f)
	local r, g, b = bg:GetVertexColor()
	local defaultBgColor = { r, g, b }

	local bar = CreateFrame('StatusBar', nil, bd)
	bar:SetStatusBarTexture(m.statusbars.default.file)
	bar:SetStatusBarColor(unpack(defaultBarColor))
	bar:SetAllPoints()
	bar:SetPoint('TOPLEFT', 1, -1)
	bar:SetPoint('BOTTOMRIGHT', -1, 1)
	AelUIPlayerHealth = bar

	local function update(self, event, ...)
		local current = UnitHealth(self.unit)
		local max = UnitHealthMax(self.unit)

		bar:SetMinMaxValues(0, max)
		bar:SetValue(current)

		local color = defaultBgColor
		if UnitIsPlayer(self.unit) then
			local _, class = UnitClass(self.unit)
			if class then
				local c = RAID_CLASS_COLORS[class]
				if c then
					color = { c.r, c.g, c.b, 1 }
				end
			end
		end

		bg:SetVertexColor(color[1] * 0.85, color[2] * 0.85, color[3] * 0.85)
		bar:SetStatusBarColor(unpack(defaultBarColor))
	end

	f:RegisterCallback('UNIT_HEALTH', update)
	f:RegisterCallback('UNIT_HEALTH_FREQUENT', update)
	f:RegisterCallback('UNIT_MAXHEALTH', update)

	update(f, 'UNIT_HEALTH', unit)

	return bd
end
