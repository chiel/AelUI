local addon = select(2, ...)

local ufConfig = addon.config.unitframes
local round = addon.utils.Round

addon.units.targettarget = {
	spawn = function(self)
		local f = self:Spawn('targettarget', 'AelUITargetTarget')

		f:SetSize(ufConfig.height * 4, ufConfig.height / 2)
		f:SetPoint('BOTTOMLEFT', AelUITarget, 'BOTTOMRIGHT', 4, 0)
	end,

	style = function(self, unit)
		self:RegisterForClicks 'AnyUp'
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = addon.colors

		local health = addon.elements.Health(self, unit)
		health:SetAllPoints()

		local name = addon.elements.Text(self.Health, { size = round(ufConfig.height * 0.5) })
		name:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -round(ufConfig.height * 0.1), -(ufConfig.height * 0.15))
		name:SetJustifyH 'RIGHT'
		self:Tag(name, '[AelUI:name]')
		health.PostUpdateColor = function(r, g, b)
			name:SetTextColor(r, g, b)
		end

		local raidMarker = addon.elements.RaidMarker(self, unit)
		raidMarker:SetParent(self.Health)
		raidMarker:SetPoint('CENTER', self.Health)
	end,
}
