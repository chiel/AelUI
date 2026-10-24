local _, ns = ...

local h = ns.unitframes.helpers

ns.unitframes.units.spawn = function(unit, fn)
	local name = 'AelUI' .. unit:sub(1, 1):upper() .. unit:sub(2) .. 'Frame'
	local f = CreateFrame('Button', name, AelUIParent, 'SecureUnitButtonTemplate, PingableUnitFrameTemplate')

	f.unit = unit
	f:SetAttribute('unit', unit)
	f:SetScript('OnEnter', UnitFrame_OnEnter)
	f:SetScript('OnLeave', UnitFrame_OnLeave)

	f:RegisterForClicks('AnyUp')
	f:SetAttribute('*type1', 'target')
	f:SetAttribute('*type2', 'togglemenu')

	RegisterUnitWatch(f)

	h.addCallbacks(f)

	if unit == 'target' then
		f:RegisterEvent('PLAYER_TARGET_CHANGED')
		f.eventCallbacks['PLAYER_TARGET_CHANGED'] = {
			function(self)
				self:Update()
			end,
		}
	elseif unit == 'pet' then
		f:RegisterEvent('UNIT_PET')
		f.eventCallbacks['UNIT_PET'] = {
			function(self, event, unit)
				if unit == 'player' then
					self:Update()
				end
			end,
		}
	end

	fn(f)
end
