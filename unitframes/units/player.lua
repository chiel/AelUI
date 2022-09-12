local addon = select(2, ...)

addon.units.player = {
	spawn = function(self)
		local f = self:Spawn('player', 'AelUIPlayer')
		f:SetSize(300, 38)
		f:SetPoint('TOPRIGHT', addon.uiAnchor, 'TOPLEFT', -21, -1)
	end,

	style = function(self, unit)
		self:RegisterForClicks 'AnyUp'
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = addon.colors

		addon.elements.Health(self, unit)
		self.Health:SetAllPoints()

		local name = addon.elements.Text(self.Health)
		self:Tag(name, '[AelUI:name]')
		name:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 4, -6)

		local healthpercent = addon.elements.Text(self.Health)
		self:Tag(healthpercent, '[AelUI:healthpercent]')
		healthpercent:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -4, -4)

		local currenthealth = addon.elements.Text(self.Health, { size = 14 })
		self:Tag(currenthealth, '[AelUI:currenthealth]')
		currenthealth:SetPoint('BOTTOMRIGHT', healthpercent, 'TOPRIGHT', 0, 0)
	end,
}
