local addon = select(2, ...)

local ufConfig = addon.config.unitframes
local round = addon.utils.Round

addon.units.target = {
	spawn = function(self)
		local f = self:Spawn('target', 'AelUITarget')
		f:SetSize(ufConfig.height * 8, ufConfig.height)
		f:SetPoint('TOPLEFT', addon.uiAnchor, 'TOPRIGHT', 20, 0)
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

		local currentpower = addon.elements.Text(power, { size = round(ufConfig.height * 0.35) })
		currentpower:SetPoint('RIGHT', power, 'LEFT', -4, 0)
		self:Tag(currentpower, '[AelUI:currentpower]')

		local buffSize = 24
		local buffSpacing = 2
		local buffColumns = 6
		local buffRows = 2

		local buffs = CreateFrame('Frame', nil, self)
		buffs.size = buffSize
		buffs.spacing = buffSpacing
		buffs:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 0, 2)
		buffs:SetSize((buffSize + buffSpacing) * buffColumns, (buffSize + buffSpacing) * buffRows)
		self.Buffs = buffs
	end,
}
