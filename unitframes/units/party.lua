local addon = select(2, ...)

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
			-48,
			'groupBy',
			'ASSIGNEDROLE',
			'groupingOrder',
			'TANK,HEALER,DAMAGER',
			'oUF-initialConfigFunction',
			[[
				self:SetWidth(250)
				self:SetHeight(40)
			]]
		)

		party:SetPoint('BOTTOMRIGHT', addon.uiAnchor, 'TOPLEFT', -368, 48)
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

		local name = addon.elements.Text(self.Health)
		name:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 4, -6)
		self:Tag(name, '[AelUI:name]')

		addon.elements.Leader(self, unit)
		self.LeaderIndicator:SetParent(self.Health)
		self.LeaderIndicator:SetPoint('LEFT', name, 'RIGHT', 4, -1)

		local groupRole = addon.elements.GroupRole(self, unit)
		groupRole:SetParent(self.Health)
		groupRole:SetPoint('RIGHT', self.Health, 'TOPRIGHT', -4, 0)

		self.Range = {
			insideAlpha = 1,
			outsideAlpha = 0.5,
		}
	end,
}
