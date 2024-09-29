local _, ns = ...

local oUF = ns.oUF

oUF.Tags.Events['AelUI:powercurrent'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER'
oUF.Tags.Methods['AelUI:powercurrent'] = UnitPower
