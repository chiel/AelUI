local addon = select(2, ...)

local ufConfig = addon.config.unitframes
local round = addon.utils.Round

addon.units.focus = {
	spawn = function(self)
		local f = self:Spawn('focus', 'AelUIFocus')
		f:SetSize(ufConfig.height * 7, ufConfig.height)
		f:SetPoint('BOTTOMRIGHT', addon.uiAnchor, 'TOPLEFT', -20, 140)
	end,

	style = addon.unitframes.style,
}
