local addon = select(2, ...)

addon.units.boss = {
	spawn = function(self)
		local boss = {}
		for i = 1, MAX_BOSS_FRAMES or 5 do
			local f = self:Spawn('boss' .. i)
			f:SetSize(250, 40)

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

		local health = addon.elements.Health(self, unit)
		health:SetAllPoints()

		local power = addon.elements.Power(self, unit)
		power:SetPoint('TOPRIGHT', self, 'BOTTOMRIGHT', 0, -4)
		power:SetSize(100, 6)

		local castbar = addon.elements.Castbar(self, unit)
		castbar:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', 0, -4)
		castbar:SetPoint('TOPRIGHT', self.Power, 'TOPLEFT', -4, 0)
		castbar:SetHeight(6)
		castbar.Time:Hide()

		local name = addon.elements.Text(self.Health)
		name:SetJustifyH 'RIGHT'
		name:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -4, -6)
		self:Tag(name, '[AelUI:name]')

		local healthpercent = addon.elements.Text(self.Health)
		healthpercent:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', 4, -4)
		self:Tag(healthpercent, '[AelUI:healthpercent]')

		local currenthealth = addon.elements.Text(self.Health, { size = 14 })
		currenthealth:SetPoint('BOTTOMLEFT', healthpercent, 'TOPLEFT', 0, 0)
		self:Tag(currenthealth, '[AelUI:currenthealth]')
	end,
}
