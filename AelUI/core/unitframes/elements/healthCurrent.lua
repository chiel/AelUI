local _, ns = ...

local m = ns.media

ns.unitframes.elements.healthCurrent = function(f, parent, options)
	local o = options or {}

	local text = (parent or f):CreateFontString(nil, 'OVERLAY')
	text:SetFont(m.fonts.default.file, o.fontSize or 14, 'OUTLINE')
	text:SetJustifyH(o.justifyH or 'LEFT')

	local function update(self)
		local current = UnitHealth(self.unit)
		local max = UnitHealthMax(self.unit)

		if max == 0 then
			text:SetText('')
			return
		end

		if UnitIsDead(self.unit) then
			text:SetText('Dead')
		elseif UnitIsGhost(self.unit) then
			text:SetText('Ghost')
		elseif max == 100 then
			text:SetText('')
		else
			text:SetText(AbbreviateNumbers(current))
		end
	end

	f:RegisterCallback('UNIT_HEALTH', update)
	f:RegisterCallback('UNIT_HEALTH_FREQUENT', update)
	f:RegisterCallback('UNIT_MAXHEALTH', update)

	update(f)

	return text
end
