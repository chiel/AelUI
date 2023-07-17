local addon = select(2, ...)

local ufConfig = addon.config.unitframes
local round = addon.utils.Round

addon.units.target = {
	spawn = function(self)
		local f = self:Spawn('target', 'AelUITarget')
		f:SetSize(ufConfig.height * 8, ufConfig.height)
		f:SetPoint('TOPLEFT', addon.uiAnchor, 'TOPRIGHT', 20, 0)
	end,

	style = addon.unitframes.style,
}
