local _, ns = ...

ns.unitframes.elements.healthCurrentText = function(f, parent, options)
	local text = ns.unitframes.elements.text(parent or f, options)

	local function update(self)
		if UnitIsDead(self.unit) or UnitIsGhost(self.unit) then
			text:SetText('')
			return
		end

		local health = UnitHealth(self.unit, true)
		text:SetText(AbbreviateNumbers(health))
	end

	f:RegisterCallback('UNIT_HEALTH', update)
	f:RegisterCallback('UNIT_MAXHEALTH', update)

	update(f)

	return text
end
