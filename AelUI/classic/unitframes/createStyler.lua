local addon = select(2, ...)

local ce = addon.core.unitframes.elements

addon.classic.unitframes.createStyler = function(config)
	local indicators = config.indicators or {}
	local texts = config.texts or {}

	return function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = addon.core.colors

		local health = ce.health(self, unit)
		health:SetAllPoints()

		local nameIndicators = addon.core.unitframes.createIndicatorGroup(self.Health)

		if texts.name then
			local nameText = ce.text(self.Health, { size = 19 })
			nameText:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 3, -6)
			self:Tag(nameText, '[AelUI:name]')

			health.PostUpdateColor = function(r, g, b)
				nameText:SetTextColor(r, g, b)
			end

			nameIndicators:SetPoint('LEFT', nameText, 'RIGHT', 4, 0)
		else
			nameIndicators:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 3, -6)
		end

		if texts.health or texts.healthpercent then
			local bottomText = ce.text(self.Health, { size = 20 })
			bottomText:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -4, -4)
			self:Tag(bottomText, texts.healthpercent and '[AelUI:healthpercent]' or '[AelUI:healthcurrent]')

			if texts.health and texts.healthpercent then
				local topText = ce.text(self.Health, { size = 14 })
				topText:SetPoint('BOTTOMRIGHT', bottomText, 'TOPRIGHT')
				self:Tag(topText, '[AelUI:healthcurrent]')
			end
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
			pvp:SetPoint('RIGHT', self, 'LEFT')
		end
	end
end
