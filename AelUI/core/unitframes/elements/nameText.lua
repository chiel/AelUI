local _, ns = ...

local m = ns.media

ns.unitframes.elements.nameText = function(f, parent, options)
	local o = options or {}

	local text = (parent or f):CreateFontString(nil, 'OVERLAY')
	text:SetFont(m.fonts.default.file, o.fontSize or 16, 'OUTLINE')

	local function update(self)
		local name = UnitName(self.unit)
		if o.maxLength and name then
			name = name:utf8sub(1, o.maxLength)
		end
		text:SetText(name)

		if UnitIsPlayer(self.unit) then
			local _, class = UnitClass(self.unit)
			if class then
				local c = RAID_CLASS_COLORS[class]
				if c then
					text:SetTextColor(c.r, c.g, c.b)
					return
				end
			end
		else
			local reaction = UnitReaction(self.unit, 'player')
			if reaction then
				local c = FACTION_BAR_COLORS[reaction]
				if c then
					text:SetTextColor(c.r, c.g, c.b)
					return
				end
			end
		end

		text:SetTextColor(1, 1, 1)
	end

	f:RegisterCallback('UNIT_NAME_UPDATE', update)

	update(f)

	return text
end
