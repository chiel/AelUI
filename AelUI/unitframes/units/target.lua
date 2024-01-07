local addon = select(2, ...)

local ufConfig = addon.core.config.unitframes
local anchors = addon.core.anchors
local round = addon.core.utils.round

addon.units.target = {
	spawn = function(self)
		local f = self:Spawn('target', 'AelUITarget')
		f:SetSize(ufConfig.height * 8, ufConfig.height)
		f:SetPoint('TOPLEFT', addon.core.anchors.primary, 'TOPRIGHT', 20, 0)
	end,

	style = addon.unitframes.style,
}
