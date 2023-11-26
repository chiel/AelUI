local addon = select(2, ...)

local ufConfig = addon.config.unitframes
local round = addon.utils.Round

addon.units.pet = {
	spawn = function(self)
		local f = self:Spawn('pet', 'AelUIPet')
		f:SetSize(ufConfig.height * 4, ufConfig.height / 2)
		f:SetPoint('BOTTOMRIGHT', AelUIPlayer, 'BOTTOMLEFT', -4, 0)
	end,

	style = function(self, unit)
		self:RegisterForClicks('AnyUp')
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

		local raidMarker = addon.elements.RaidMarker(self, unit)
		raidMarker:SetParent(self.Health)
		raidMarker:SetPoint('CENTER', self.Health)
	end,
}
