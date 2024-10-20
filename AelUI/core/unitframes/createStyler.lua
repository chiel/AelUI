local _, ns = ...

local e = ns.unitframes.elements

ns.unitframes.createStyler = function(config)
	local c = config or {}
	local i = c.indicators or {}
	local t = c.texts or {}

	return function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)
		self.colors = ns.colors

		local health = e.health(self, unit)
		health:SetAllPoints()

		local nameText = e.text(self.Health, { size = 20 })
		self:Tag(nameText, '[AelUI:name]')

		health.PostUpdateColor = function(r, g, b)
			nameText:SetTextColor(r, g, b)
		end

		if c.mirror then
			nameText:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -4, -6)
		else
			nameText:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 4, -6)
		end

		if t.health or t.healthpercent then
			local bottomText = e.text(self.Health, { size = 20 })
			if config.mirror then
				bottomText:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', 6, -4)
			else
				bottomText:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -4, -4)
			end
			self:Tag(bottomText, t.healthpercent and '[AelUI:healthpercent]' or '[AelUI:healthcurrent]')

			if t.health and t.healthpercent then
				local topText = e.text(self.Health, { size = 14, style = 'bold' })
				if config.mirror then
					topText:SetPoint('BOTTOMLEFT', bottomText, 'TOPLEFT')
				else
					topText:SetPoint('BOTTOMRIGHT', bottomText, 'TOPRIGHT')
				end
				self:Tag(topText, '[AelUI:healthcurrent]')
			end
		end

		if i.leader then
			local leader = e.leader(self, unit)
			leader:SetParent(self.Health)
			leader:SetPoint('LEFT', nameText, 'RIGHT', 4, -1)
		end
	end
end
