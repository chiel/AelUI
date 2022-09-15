local addon = select(2, ...)

addon.units.target = {
	spawn = function(self)
		local f = self:Spawn('target', 'AelUITarget')
		f:SetSize(300, 38)
		f:SetPoint('TOPLEFT', addon.uiAnchor, 'TOPRIGHT', 21, -1)
	end,

	style = function(self, unit)
		self:RegisterForClicks 'AnyUp'
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = addon.colors

		addon.elements.Health(self, unit)
		self.Health:SetAllPoints()

		addon.elements.Power(self, unit)
		self.Power:SetPoint('TOPRIGHT', self, 'BOTTOMRIGHT', 0, -6)
		self.Power:SetSize(100, 4)

		local name = addon.elements.Text(self.Health)
		self:Tag(name, '[AelUI:name]')
		name:SetJustifyH 'RIGHT'
		name:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -4, -6)

		local healthpercent = addon.elements.Text(self.Health)
		self:Tag(healthpercent, '[AelUI:healthpercent]')
		healthpercent:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', 4, -4)

		local currenthealth = addon.elements.Text(self.Health, { size = 14 })
		self:Tag(currenthealth, '[AelUI:currenthealth]')
		currenthealth:SetPoint('BOTTOMLEFT', healthpercent, 'TOPLEFT', 0, 0)
	end,
}
