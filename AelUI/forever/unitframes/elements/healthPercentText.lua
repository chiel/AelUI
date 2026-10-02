local _, ns = ...

ns.unitframes.elements.healthPercentText = function(f, parent, options)
	local text = ns.unitframes.elements.text(parent or f, options)

	local function update(self)
		if UnitIsDead(self.unit) or UnitIsGhost(self.unit) then
			text:SetText('DEAD')
			return
		end

		local pct = UnitHealthPercent(self.unit, true, CurveConstants.ScaleTo100)
		text:SetFormattedText('%.1f%%', pct)
	end

	f:RegisterCallback('UNIT_HEALTH', update)
	f:RegisterCallback('UNIT_MAXHEALTH', update)

	update(f)

	return text
end
