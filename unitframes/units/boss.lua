local addon = select(2, ...)

addon.units.boss = {
	spawn = function(self)
		local boss = {}
		for i = 1, MAX_BOSS_FRAMES or 5 do
			local f = self:Spawn('boss' .. i)
			f:SetSize(250, 38)

			if i == 1 then
				-- boss[i]:SetPoint('TOPLEFT', UIParent, 'CENTER', 596, 200)
				f:SetPoint('TOPLEFT', AelUITarget, 'TOPRIGHT', 106, 500)
			else
				f:SetPoint('TOPLEFT', boss[i - 1], 'BOTTOMLEFT', 0, -42)
			end

			boss[i] = f
		end
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

		addon.elements.Castbar(self, unit)
		self.Castbar:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', 0, -6)
		self.Castbar:SetPoint('TOPRIGHT', self.Power, 'TOPLEFT', -6, 0)
		self.Castbar:SetHeight(4)
		self.Castbar.Time:Hide()

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
