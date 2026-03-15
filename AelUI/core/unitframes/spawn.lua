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
	f.updaters = {}

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
			if event:match('^UNIT_') then
				self:RegisterUnitEvent(event, f.unit)
			else
				self:RegisterEvent(event)
			end
		end
		table.insert(self.eventCallbacks[event], cb)

		f.updaters[cb] = true
	end

	f.Update = function(self)
		for cb in pairs(self.updaters) do
			cb(self)
		end
	end

	f:SetScript('OnShow', function(self)
		self:Update()
	end)

	if unit == 'target' then
		f:RegisterEvent('PLAYER_TARGET_CHANGED')
		f.eventCallbacks['PLAYER_TARGET_CHANGED'] = {
			function(self)
				self:Update()
			end,
		}
	elseif unit == 'targettarget' then
		f:RegisterEvent('PLAYER_TARGET_CHANGED')
		f.eventCallbacks['PLAYER_TARGET_CHANGED'] = {
			function(self)
				self:Update()
			end,
		}
		f:RegisterEvent('UNIT_TARGET')
		f.eventCallbacks['UNIT_TARGET'] = {
			function(self, event, unit)
				if unit == 'target' then
					self:Update()
				end
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

	return f
end
