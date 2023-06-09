local addon = select(2, ...)

local ufConfig = addon.config.unitframes
local round = addon.utils.Round

addon.units.player = {
	spawn = function(self)
		local f = self:Spawn('player', 'AelUIPlayer')
		f:SetSize(ufConfig.height * 8, ufConfig.height)
		f:SetPoint('TOPRIGHT', addon.uiAnchor, 'TOPLEFT', -20, 0)
	end,

	style = addon.unitframes.style,
}
