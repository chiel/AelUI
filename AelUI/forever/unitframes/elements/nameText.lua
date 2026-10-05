local _, ns = ...

ns.unitframes.elements.nameText = function(f, parent, options)
	local text = ns.unitframes.elements.text(parent or f, options)

	local function update(self)
		local firstName, lastName = UnitName(self.unit)
		text:SetText(firstName .. ' ' .. lastName)

		local color = { 1, 1, 1 }

		if UnitIsDead(self.unit) or UnitIsGhost(self.unit) then
			color = { 0.3, 0.3, 0.3 }
		elseif UnitIsPlayer(self.unit) then
			local _, classToken = UnitClass(self.unit)

			if classToken then
				local c = C_ClassColor.GetClassColor(classToken)
				color = { c.r, c.g, c.b }
			end
		else
			local reaction = UnitReaction(self.unit, 'player')
			if reaction then
				local c = FACTION_BAR_COLORS[reaction]
				if c then
					color = { c.r, c.g, c.b }
				end
			end
		end

		text:SetTextColor(unpack(color))
	end

	f:RegisterCallback('UNIT_FACTION', update)
	f:RegisterCallback('UNIT_NAME_UPDATE', update)

	update(f)

	return text
end
