local addon = select(2, ...)

local oUF = addon.oUF

oUF.Tags.Events['AelUI:healthcurrent'] = 'UNIT_HEALTH UNIT_MAXHEALTH'
oUF.Tags.Methods['AelUI:healthcurrent'] = function(unit)
	local hp = UnitHealth(unit)
	if hp == 0 then
		return ''
	end
	return hp < 10000 and hp or AbbreviateNumbers(hp)
end

oUF.Tags.Events['AelUI:healthpercent'] = 'UNIT_HEALTH UNIT_MAXHEALTH'
oUF.Tags.Methods['AelUI:healthpercent'] = function(unit)
	local hp = UnitHealth(unit)
	if hp == 0 then
		return 'DEAD'
	end

	local max = UnitHealthMax(unit)
	if max == 0 then
		return 0
	end

	return string.format('%d%%', math.floor(hp / max * 100 + 0.5))
end

oUF.Tags.Events['AelUI:name'] = 'UNIT_NAME_UPDATE'
oUF.Tags.Methods['AelUI:name'] = function(unit)
	local name = UnitName(unit)
	return name
end
