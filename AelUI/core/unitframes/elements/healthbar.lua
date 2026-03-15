local _, ns = ...

local h = ns.helpers

local defaultBarColor = { 35 / 255, 35 / 255, 35 / 255 }

ns.unitframes.elements.healthbar = function(f, options)
	local bar, bd, bg = h.createStatusBar(f, options)
	bar:SetStatusBarColor(unpack(defaultBarColor))

	local r, g, b = bg:GetVertexColor()
	local defaultBgColor = { r, g, b }

	local function update(self)
		local current = UnitHealth(self.unit)
		local max = UnitHealthMax(self.unit)

		if max == 0 then
			bar:SetMinMaxValues(0, 1)
			bar:SetValue(1)
			return
		end

		bar:SetMinMaxValues(0, max)
		bar:SetValue(current)

		local color = defaultBgColor

		if UnitIsDead(self.unit) or UnitIsGhost(self.unit) then
			bg:SetVertexColor(0.3, 0.3, 0.3)
			bar:SetStatusBarColor(unpack(defaultBarColor))
			return
		end
		if UnitIsPlayer(self.unit) then
			local _, class = UnitClass(self.unit)
			if class then
				local c = RAID_CLASS_COLORS[class]
				if c then
					color = { c.r, c.g, c.b, 1 }
				end
			end
		else
			local reaction = UnitReaction(self.unit, 'player')
			if reaction then
				local c = FACTION_BAR_COLORS[reaction]
				if c then
					color = { c.r, c.g, c.b, 1 }
				end
			end
		end

		bg:SetVertexColor(color[1] * 0.75, color[2] * 0.75, color[3] * 0.75)
		bar:SetStatusBarColor(unpack(defaultBarColor))
	end

	f:RegisterCallback('UNIT_HEALTH', update)
	f:RegisterCallback('UNIT_HEALTH_FREQUENT', update)
	f:RegisterCallback('UNIT_MAXHEALTH', update)

	update(f)

	return bd, bar
end
