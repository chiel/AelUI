local ns = select(2, ...)

local oUF = ns.oUF

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

oUF.Tags.Events['AelUI:level'] = 'UNIT_LEVEL PLAYER_LEVEL_UP'
oUF.Tags.Methods['AelUI:level'] = function(unit)
	local l = (UnitEffectiveLevel or UnitLevel)(unit)
	local c = UnitClassification(u)

	local sc = ''
	if c == 'rare' then
		sc = 'R'
	elseif c == 'rareelite' then
		sc = 'R+'
	elseif c == 'elite' then
		sc = '+'
	elseif c == 'worldboss' then
		sc = 'B'
	elseif c == 'minus' then
		sc = '-'
	end

	if l > 0 then
		return l .. sc
	else
		return '??' .. sc
	end
end

oUF.Tags.Events['AelUI:name'] = 'UNIT_NAME_UPDATE'
oUF.Tags.Methods['AelUI:name'] = UnitName

oUF.Tags.Events['AelUI:powercurrent'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER'
oUF.Tags.Methods['AelUI:powercurrent'] = UnitPower

oUF.Tags.Events['AelUI:raidtext'] = 'UNIT_NAME_UPDATE UNIT_HEALTH UNIT_CONNECTION'
oUF.Tags.Methods['AelUI:raidtext'] = function(unit)
	local name = UnitName(unit)
	return name:utf8sub(0, 3)
end
