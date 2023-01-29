local addon = select(2, ...)

oUF.Tags.Events['AelUI:currenthealth'] = 'UNIT_HEALTH UNIT_MAXHEALTH'
oUF.Tags.Methods['AelUI:currenthealth'] = function(unit)
	local hp = UnitHealth(unit)
	if hp == 0 then
		return ''
	end
	return AbbreviateNumbers(hp)
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

oUF.Tags.Events['AelUI:currentpower'] = 'UNIT_POWER_UPDATE UNIT_MAXPOWER'
oUF.Tags.Methods['AelUI:currentpower'] = UnitPower

oUF.Tags.Events['AelUI:name'] = 'UNIT_NAME_UPDATE'
oUF.Tags.Methods['AelUI:name'] = function(unit)
	local name = UnitName(unit)
	return name
end

oUF.Tags.Events['AelUI:raidtext'] = 'UNIT_NAME_UPDATE UNIT_HEALTH UNIT_CONNECTION'
oUF.Tags.Methods['AelUI:raidtext'] = function(unit)
	local name = UnitName(unit)
	return name:utf8sub(0, 3)
end
