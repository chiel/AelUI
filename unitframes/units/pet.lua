local addon = select(2, ...)

addon.units.pet = {
	spawn = function(self)
		local f = self:Spawn('pet', 'AelUIPet')
		f:SetSize(150, 20)
		f:SetPoint('BOTTOMRIGHT', AelUIPlayer, 'BOTTOMLEFT', -4, 0)
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
	end,
}
