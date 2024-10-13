local _, ns = ...

local oUF = ns.oUF

oUF.Tags.Events['AelUI:name'] = 'UNIT_NAME_UPDATE'
oUF.Tags.Methods['AelUI:name'] = UnitName

oUF.Tags.Events['AelUI:powercurrent'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER'
oUF.Tags.Methods['AelUI:powercurrent'] = UnitPower
