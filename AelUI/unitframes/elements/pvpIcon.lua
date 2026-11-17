local _, ns = ...

-- pvp icon textures:
-- alliance: 8036209
local PVP_ICON_ALLIANCE = 8036209
local PVP_ICON_HORDE = 8036209

ns.unitframes.elements.pvpIcon = function(f, parent)
	local icon = parent:CreateTexture(nil, 'OVERLAY')

	local function update(self)
		icon:SetTexture(PVP_ICON_ALLIANCE)
		icon:Show()
	end

	f:RegisterCallback('GROUP_ROSTER_UPDATE', update)
	f:RegisterCallback('PARTY_LEADER_CHANGED', update)

	update(f)

	return icon
end
