local _, ns = ...

local h = ns.unitframes.helpers

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

	local header = CreateFrame('Frame', name, o.parent or AelUIParent, o.template or 'SecureGroupHeaderTemplate')

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

		h.addCallbacks(f)

		local styled = false
		f:HookScript('OnAttributeChanged', function(self, key, value)
			if key ~= 'unit' then
				return
			end

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
	end

	header:Show()

	return header
end
