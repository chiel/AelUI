local ns = select(2, ...)

local ce = ns.unitframes.elements

ns.unitframes.createStyler = function(config)
	local indicators = config.indicators or {}
	local texts = config.texts or {}

	return function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = ns.colors

		local health = ce.health(self, unit)
		health:SetAllPoints()

		local nameText = ce.text(self.Health, { size = 20 })
		self:Tag(nameText, '[AelUI:name]')

		health.PostUpdateColor = function(r, g, b)
			nameText:SetTextColor(r, g, b)
		end

		if config.mirror then
			nameText:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -4, -6)
		else
			nameText:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 4, -6)
		end

		if texts.health or texts.healthpercent then
			local bottomText = ce.text(self.Health, { size = 20 })
			if config.mirror then
				bottomText:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', 6, -4)
			else
				bottomText:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -4, -4)
			end
			self:Tag(bottomText, texts.healthpercent and '[AelUI:healthpercent]' or '[AelUI:healthcurrent]')

			if texts.health and texts.healthpercent then
				local topText = ce.text(self.Health, { size = 14, style = 'bold' })
				if config.mirror then
					topText:SetPoint('BOTTOMLEFT', bottomText, 'TOPLEFT')
				else
					topText:SetPoint('BOTTOMRIGHT', bottomText, 'TOPRIGHT')
				end
				self:Tag(topText, '[AelUI:healthcurrent]')
			end
		end

		if indicators.leader then
			local leader = ce.leader(self, unit)
			leader:SetParent(self.Health)
			if config.mirror then
				leader:SetPoint('RIGHT', nameText, 'LEFT', -4, -1)
			else
				leader:SetPoint('LEFT', nameText, 'RIGHT', 4, -1)
			end
		end

		if indicators.raidmarker then
			local raidMarker = ce.raidMarker(self, unit)
			raidMarker:SetParent(self.Health)
			raidMarker:SetPoint('CENTER')
		end

		if config.range then
			self.Range = {
				insideAlpha = 1,
				outsideAlpha = 0.5,
			}
		end
	end
end
