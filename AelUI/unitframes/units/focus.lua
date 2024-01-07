local addon = select(2, ...)

local ufConfig = addon.core.config.unitframes
local anchors = addon.core.anchors
local round = addon.core.utils.round

addon.units.focus = {
	spawn = function(self)
		local f = self:Spawn('focus', 'AelUIFocus')
		f:SetSize(ufConfig.height * 7, ufConfig.height)
		f:SetPoint('BOTTOMRIGHT', anchors.primary, 'TOPLEFT', -20, 140)
	end,

	style = addon.unitframes.style,
}
