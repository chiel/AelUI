local addon = select(2, ...)

local ufConfig = addon.config.unitframes
local round = addon.utils.Round

addon.units.boss = {
	spawn = function(self)
		local boss = {}
		for i = 1, MAX_BOSS_FRAMES or 5 do
			local f = self:Spawn('boss' .. i)
			f:SetSize(ufConfig.height * 7, ufConfig.height)

			if i == 1 then
				f:SetPoint(
					'TOPLEFT',
					AelUIAnchor,
					'TOPRIGHT',
					(ufConfig.height * 8) + 20 + 4,
					ufConfig.height * (5 + 2 + (1.5 * 4))
				)
			else
				f:SetPoint('TOPLEFT', boss[i - 1], 'BOTTOMLEFT', 0, -(ufConfig.height * 1.5))
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

		local name = addon.elements.Text(self.Health, { size = round(ufConfig.height * 0.5) })
		name:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -round(ufConfig.height * 0.1), -(ufConfig.height * 0.15))
		name:SetJustifyH 'RIGHT'
		self:Tag(name, '[AelUI:name]')
		health.PostUpdateColor = function(r, g, b)
			name:SetTextColor(r, g, b)
		end

		local healthpercent = addon.elements.Text(self.Health, { size = round(ufConfig.height * 0.5) })
		healthpercent:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', ufConfig.height * 0.1, -(ufConfig.height * 0.1))
		self:Tag(healthpercent, '[AelUI:healthpercent]')

		local currenthealth = addon.elements.Text(self.Health, { size = round(ufConfig.height * 0.35) })
		currenthealth:SetPoint('BOTTOMLEFT', healthpercent, 'TOPLEFT', 0, 0)
		self:Tag(currenthealth, '[AelUI:currenthealth]')
	end,
}
