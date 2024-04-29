local ns = select(2, ...)

local ce = ns.core.unitframes.elements

ns.classic.unitframes.createStyler = function(config)
	local indicators = config.indicators or {}
	local texts = config.texts or {}

	return function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = ns.core.colors

		local health = ce.health(self, unit)
		health:SetAllPoints()

		local nameIndicators = ns.core.unitframes.createIndicatorGroup(self.Health, config.mirror == true)
		if config.mirror then
			nameIndicators:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -3, 4)
		else
			nameIndicators:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 3, 4)
		end

		if texts.name then
			local nameText = ce.text(self.Health, { size = 20 })
			self:Tag(nameText, '[AelUI:name]')

			health.PostUpdateColor = function(r, g, b)
				nameText:SetTextColor(r, g, b)
			end

			nameIndicators:Add(nameText)
		end

		if texts.level then
			local levelText = ce.text(self.Health, { size = 16, style = 'bold' })
			self:Tag(levelText, '[AelUI:level]')
			nameIndicators:Add(levelText, -1)
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

		if indicators.resting then
			local resting = ce.resting(self, unit)
			nameIndicators:Add(resting)
		end

		if indicators.leader then
			local leader = ce.leader(self, unit)
			nameIndicators:Add(leader)
		end

		if indicators.masterlooter then
			local masterlooter = ce.masterlooter(self, unit)
			nameIndicators:Add(masterlooter, 1)
		end

		if indicators.combat then
			local combat = ce.combat(self, unit)
			combat:SetParent(self.Health)
			combat:SetPoint('CENTER', self.Health, 'CENTER')
		end

		if indicators.pvp then
			local pvp = ce.pvp(self, unit)
			pvp:SetParent(self.Health)
			if config.mirror then
				pvp:SetPoint('LEFT', self, 'RIGHT')
			else
				pvp:SetPoint('RIGHT', self, 'LEFT')
			end
		end
	end
end
