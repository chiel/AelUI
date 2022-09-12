local addon = select(2, ...)

oUF.Tags.Events['AelUI:currenthealth'] = 'UNIT_HEALTH UNIT_MAXHEALTH'
oUF.Tags.Methods['AelUI:currenthealth'] = function(unit)
	return AbbreviateNumbers(UnitHealth(unit))
end

oUF.Tags.Events['AelUI:healthpercent'] = 'UNIT_HEALTH UNIT_MAXHEALTH'
oUF.Tags.Methods['AelUI:healthpercent'] = function(unit)
	local max = UnitHealthMax(unit)
	if max == 0 then
		return 0
	end

	return string.format('%d%%', math.floor(UnitHealth(unit) / max * 100 + 0.5))
end

oUF.Tags.Events['AelUI:name'] = 'UNIT_NAME_UPDATE UNIT_CONNECTION UNIT_FACTION'
oUF.Tags.Methods['AelUI:name'] = function(unit)
	local name = UnitName(unit)
	local color = addon.utils.UnitColor(unit)

	if color then
		return addon.utils.Hex(color) .. name
	end

	return name
end
