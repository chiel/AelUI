local _, ns = ...

ns.unitframes.helpers.addCallbacks = function(f)
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
				self:RegisterUnitEvent(event, self.unit)
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
end
