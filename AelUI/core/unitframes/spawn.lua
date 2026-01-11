local _, ns = ...

ns.unitframes.spawn = function(unit)
	local name = 'AelUI' .. unit:sub(1, 1):upper() .. unit:sub(2) .. 'Frame'

	local f = CreateFrame('Button', name, AelUIParent, 'SecureUnitButtonTemplate')

	f.unit = unit
	f:SetAttribute('unit', unit)
	f:SetScript('OnEnter', UnitFrame_OnEnter)
	f:SetScript('OnLeave', UnitFrame_OnLeave)

	f:RegisterForClicks('AnyUp')
	f:SetAttribute('*type1', 'target')
	f:SetAttribute('*type2', 'togglemenu')

	return f
end
