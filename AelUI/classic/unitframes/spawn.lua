local addon = select(2, ...)

local oUF = addon.oUF
local anchors = addon.core.anchors

oUF:RegisterStyle(
	'AelUI:player',
	addon.classic.unitframes.createStyler({
		indicators = {
			combat = true,
			leader = true,
			masterlooter = true,
			pvp = true,
		},
		texts = {
			health = true,
			healthpercent = true,
			name = true,
		},
	})
)

oUF:Factory(function(self)
	local playerFrame = self:Spawn('player', 'AelUIPlayer')
	playerFrame:SetSize(40 * 7, 40)
	playerFrame:SetPoint('TOPRIGHT', anchors.primary, 'TOPLEFT', -20, 0)

	local petFrame = self:Spawn('pet', 'AelUIPet')
	petFrame:SetSize(40 * 3.5, 32)
	petFrame:SetPoint('TOPLEFT', playerFrame, 'BOTTOMLEFT', 0, -16)
end)
