local addon = select(2, ...)

local ufConfig = addon.config.unitframes
local round = addon.utils.Round

local function CreateUpdatePower(power)
	return function(self, event, unit)
		if unit ~= self.unit then
			return
		end

		local role = UnitGroupRolesAssigned(self.unit)
		local visible = role == 'HEALER'

		if visible then
			self.Power:SetMinMaxValues(0, UnitPowerMax(unit, Enum.PowerType.Mana))
			self.Power:SetValue(UnitPower(unit, Enum.PowerType.Mana))
		end

		power:SetShown(visible)
	end
end

addon.units.party = {
	spawn = function(self)
		local party = self:SpawnHeader(
			nil,
			nil,
			'party',
			'showParty',
			true,
			'showPlayer',
			true,
			'yOffset',
			-(ufConfig.height * 1.5),
			'groupBy',
			'ASSIGNEDROLE',
			'groupingOrder',
			'TANK,HEALER,DAMAGER',
			'oUF-initialConfigFunction',
			([[
				self:SetWidth(%d)
				self:SetHeight(%d)
			]]):format(ufConfig.height * 7, ufConfig.height)
		)

		party:SetPoint('TOPRIGHT', addon.uiGroupAnchor, 'TOPLEFT')
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
		self.Power.Override = CreateUpdatePower(power)

		local name = addon.elements.Text(self.Health, { size = round(ufConfig.height * 0.5) })
		name:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', round(ufConfig.height * 0.1), -(ufConfig.height * 0.15))
		self:Tag(name, '[AelUI:name]')
		health.PostUpdateColor = function(r, g, b)
			name:SetTextColor(r, g, b)
		end

		local leader = addon.elements.Leader(self, unit)
		leader:SetParent(self.Health)
		leader:SetPoint('LEFT', name, 'RIGHT', 4, -1)

		local groupRole = addon.elements.GroupRole(self, unit)
		groupRole:SetParent(self.Health)
		groupRole:SetPoint('RIGHT', self.Health, 'TOPRIGHT', -4, 0)

		local summon = addon.elements.Summon(self, unit)
		summon:SetParent(self.Health)
		summon:SetPoint('CENTER', self.Health, 'CENTER')

		local readyCheck = addon.elements.ReadyCheck(self, unit)
		readyCheck:SetParent(self.Health)
		readyCheck:SetPoint('CENTER', self.Health, 'CENTER')

		local resurrect = addon.elements.Resurrect(self, unit)
		resurrect:SetParent(self.Health)
		resurrect:SetPoint('CENTER', self.Health, 'CENTER')

		addon.elements.DispelBorder(self, unit)

		self.Range = {
			insideAlpha = 1,
			outsideAlpha = 0.5,
		}
	end,
}
