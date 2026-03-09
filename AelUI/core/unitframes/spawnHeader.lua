local _, ns = ...

local baseConfigFunction = [[
	self:SetAttribute('*type1', 'target')
	self:SetAttribute('*type2', 'togglemenu')

	local body = self:GetParent():GetAttribute('aelUI-secureSetup')
	if body then
		self:Run(body)
	end

	local header = self:GetParent()
	header:CallMethod('styleChild', self:GetName())
]]

ns.unitframes.spawnHeader = function(name, attributes, style, options)
	local o = options or {}

	local header = CreateFrame('Frame', name, o.parent or AelUIParent, 'SecureGroupHeaderTemplate')

	header:SetAttribute('template', 'AelUIUnitButtonTemplate')
	header:SetAttribute('initialConfigFunction', baseConfigFunction)

	if o.secureSetup then
		header:SetAttribute('aelUI-secureSetup', o.secureSetup)
	end

	for k, v in pairs(attributes) do
		header:SetAttribute(k, v)
	end

	function header:styleChild(frameName)
		local f = _G[frameName]

		f:SetScript('OnEnter', UnitFrame_OnEnter)
		f:SetScript('OnLeave', UnitFrame_OnLeave)

		-- Callback registry
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
			end
			if self.unit then
				if event:match('^UNIT_') then
					self:RegisterUnitEvent(event, self.unit)
				else
					self:RegisterEvent(event)
				end
			end
			table.insert(self.eventCallbacks[event], cb)
			self.updaters[cb] = true
		end

		f.Update = function(self)
			for cb in pairs(self.updaters) do
				cb(self)
			end
		end

		local styled = false
		f:HookScript('OnAttributeChanged', function(self, key, value)
			if key ~= 'unit' then return end

			self.unit = value

			if not value then
				for event in pairs(self.eventCallbacks) do
					self:UnregisterEvent(event)
				end
				return
			end

			for event in pairs(self.eventCallbacks) do
				if event:match('^UNIT_') then
					self:RegisterUnitEvent(event, value)
				else
					self:RegisterEvent(event)
				end
			end

			if not styled then
				styled = true
				style(self)
			else
				self:Update()
			end
		end)

		f:HookScript('OnShow', function(self)
			self:Update()
		end)
	end

	header:Show()

	return header
end
