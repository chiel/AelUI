local addon = select(2, ...)

addon.units.player = {
	spawn = function(self)
		local f = self:Spawn('player', 'AelUIPlayer')
		f:SetSize(300, 40)
		f:SetPoint('TOPRIGHT', addon.uiAnchor, 'TOPLEFT', -20, 0)
	end,

	style = function(self, unit)
		self:RegisterForClicks 'AnyUp'
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = addon.colors

		local health = addon.elements.Health(self, unit)
		health:SetAllPoints()

		local name = addon.elements.Text(self.Health)
		name:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 4, -6)
		self:Tag(name, '[AelUI:name]')
		health.PostUpdateColor = function(r, g, b)
			name:SetTextColor(r, g, b)
		end

		local healthpercent = addon.elements.Text(self.Health)
		healthpercent:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -4, -4)
		self:Tag(healthpercent, '[AelUI:healthpercent]')

		local currenthealth = addon.elements.Text(self.Health, { size = 14 })
		currenthealth:SetPoint('BOTTOMRIGHT', healthpercent, 'TOPRIGHT', 0, 0)
		self:Tag(currenthealth, '[AelUI:currenthealth]')

		addon.elements.Leader(self, unit)
		self.LeaderIndicator:SetParent(self.Health)
		self.LeaderIndicator:SetPoint('LEFT', name, 'RIGHT', 4, -1)
	end,
}
