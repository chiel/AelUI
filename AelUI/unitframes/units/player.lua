local addon = select(2, ...)

local ufConfig = addon.core.config.unitframes
local anchors = addon.core.anchors
local round = addon.core.utils.round

addon.units.player = {
	spawn = function(self)
		local f = self:Spawn('player', 'AelUIPlayer')
		f:SetSize(ufConfig.height * 8, ufConfig.height)
		f:SetPoint('TOPRIGHT', anchors.primary, 'TOPLEFT', -20, 0)
	end,

	style = function(self, unit)
		addon.unitframes.style(self, unit)

		AelUIPlayerCastbar = self.Castbar

		local castbar = self.CastbarBackdrop
		castbar:ClearAllPoints()
		castbar:SetPoint('TOPLEFT', anchors.secondary, 'BOTTOMLEFT', 0, -2)
		castbar:SetPoint('TOPRIGHT', anchors.secondary, 'BOTTOMRIGHT', 0, -2)
		castbar:SetHeight(16)

		castbar.Spark:SetHeight(30)
	end,
}
