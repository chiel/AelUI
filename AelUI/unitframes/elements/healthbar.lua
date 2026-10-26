local _, ns = ...

local u = ns.utils

local tint = CreateColor(0.75, 0.75, 0.75)
local defaultBarColor = { 35 / 255, 35 / 255, 35 / 255 }

ns.unitframes.elements.healthbar = function(f, options)
	local bar, bd, bg = u.createStatusBar(f, options)
	bar:SetStatusBarColor(unpack(defaultBarColor))

	local r, g, b = bg:GetVertexColor()
	local defaultBgColor = { r, g, b }

	local function update(self)
		local pct = UnitHealthPercent(self.unit, true, CurveConstants.ZeroToOne)
		bar:SetMinMaxValues(0, 1)
		bar:SetValue(pct)

		local color = defaultBgColor

		if UnitIsDead(self.unit) or UnitIsGhost(self.unit) then
			color = { 0.3, 0.3, 0.3 }
			bar:SetValue(0)
		elseif UnitIsPlayer(self.unit) then
			local _, classToken = UnitClass(self.unit)

			if classToken then
				local c = C_ClassColor.GetClassColor(classToken, tint)
				color = { c.r, c.g, c.b }
			end
		else
			local reaction = UnitReaction(self.unit, 'player')
			if reaction then
				local c = FACTION_BAR_COLORS[reaction]
				if c then
					color = { c.r * 0.75, c.g * 0.75, c.b * 0.75 }
				end
			end
		end

		bg:SetVertexColor(color[1], color[2], color[3])
		bar:SetStatusBarColor(unpack(defaultBarColor))
	end

	f:RegisterCallback('UNIT_HEALTH', update)
	f:RegisterCallback('UNIT_MAXHEALTH', update)

	update(f)

	return bd, bar
end
