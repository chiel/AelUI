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

	RegisterUnitWatch(f)

	f.eventCallbacks = {}

	f:SetScript('OnEvent', function(self, event, ...)
		if self.eventCallbacks[event] then
			for _, cb in ipairs(self.eventCallbacks[event]) do
				cb(self, event, ...)
			end
		end
	end)

	f.RegisterCallback = function(self, event, cb)
		if not self.eventCallbacks[event] then
			self.eventCallbacks[event] = {}
			self:RegisterUnitEvent(event, f.unit)
		end
		table.insert(self.eventCallbacks[event], cb)
	end

	return f
end
