local addon = select(2, ...)

local ufConfig = addon.config.unitframes
local round = addon.utils.Round

addon.units.player = {
	spawn = function(self)
		local f = self:Spawn('player', 'AelUIPlayer')
		f:SetSize(ufConfig.height * 8, ufConfig.height)
		f:SetPoint('TOPRIGHT', addon.uiAnchor, 'TOPLEFT', -20, 0)
	end,

	style = function(self, unit)
		self:RegisterForClicks 'AnyUp'
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = addon.colors

		local health = addon.elements.Health(self, unit)
		health:SetAllPoints()

		local name = addon.elements.Text(self.Health, { size = round(ufConfig.height * 0.5) })
		name:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', round(ufConfig.height * 0.1), -(ufConfig.height * 0.15))
		self:Tag(name, '[AelUI:name]')
		health.PostUpdateColor = function(r, g, b)
			name:SetTextColor(r, g, b)
		end

		local healthpercent = addon.elements.Text(self.Health, { size = round(ufConfig.height * 0.5) })
		healthpercent:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -(ufConfig.height * 0.1), -(ufConfig.height * 0.1))
		self:Tag(healthpercent, '[AelUI:healthpercent]')

		local currenthealth = addon.elements.Text(self.Health, { size = round(ufConfig.height * 0.35) })
		currenthealth:SetPoint('BOTTOMRIGHT', healthpercent, 'TOPRIGHT', 0, 0)
		self:Tag(currenthealth, '[AelUI:currenthealth]')

		local leader = addon.elements.Leader(self, unit)
		leader:SetParent(self.Health)
		leader:SetPoint('LEFT', name, 'RIGHT', 4, -1)
	end,
}
