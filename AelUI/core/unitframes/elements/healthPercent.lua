local _, ns = ...

local m = ns.media

ns.unitframes.elements.healthPercent = function(f, parent, options)
	local o = options or {}

	local text = (parent or f):CreateFontString(nil, 'OVERLAY')
	text:SetFont((o.font or m.fonts.default).file, o.fontSize or 14, 'OUTLINE')
	text:SetJustifyH(o.justifyH or 'RIGHT')

	local function update(self)
		local current = UnitHealth(self.unit)
		local max = UnitHealthMax(self.unit)

		if max == 0 then
			text:SetText('')
			return
		end

		if UnitIsDead(self.unit) or UnitIsGhost(self.unit) then
			text:SetText('')
		else
			local pct = current / max * 100
			text:SetText(string.format('%.1f%%', pct))
		end
	end

	f:RegisterCallback('UNIT_HEALTH', update)
	f:RegisterCallback('UNIT_HEALTH_FREQUENT', update)
	f:RegisterCallback('UNIT_MAXHEALTH', update)

	update(f)

	return text
end
