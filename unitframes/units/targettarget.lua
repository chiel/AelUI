local addon = select(2, ...)

addon.units.targettarget = {
	spawn = function(self)
		local f = self:Spawn('targettarget', 'AelUITargetTarget')
		f:SetSize(150, 20)
		f:SetPoint('BOTTOMLEFT', AelUITarget, 'BOTTOMRIGHT', 6, 0)
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
		name:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -4, -6)
	end,
}