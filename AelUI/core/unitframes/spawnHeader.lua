local _, ns = ...

local initialConfigFunction = [[
	self:SetAttribute('*type1', 'target')
	self:SetAttribute('*type2', 'togglemenu')

	local header = self:GetParent()
	header:CallMethod('styleChild', self:GetName())
]]

ns.unitframes.spawnHeader = function(name, attributes, style, parent)
	local header = CreateFrame('Frame', name, parent or AelUIParent, 'SecureGroupHeaderTemplate')

	header:SetAttribute('template', 'SecureUnitButtonTemplate')
	header:SetAttribute('initialConfigFunction', initialConfigFunction)

	for k, v in pairs(attributes) do
		header:SetAttribute(k, v)
	end

	function header:styleChild(frameName)
		local f = _G[frameName]

		f:RegisterForClicks('AnyUp')
		f:SetScript('OnEnter', UnitFrame_OnEnter)
		f:SetScript('OnLeave', UnitFrame_OnLeave)

		local styled = false
		f:HookScript('OnAttributeChanged', function(self, key, value)
			if key == 'unit' and value then
				self.unit = value

				if not styled then
					styled = true
					style(self)
				elseif self.Update then
					self:Update()
				end
			end
		end)

		f:HookScript('OnShow', function(self)
			if self.Update then
				self:Update()
			end
		end)
	end

	header:Show()

	return header
end
