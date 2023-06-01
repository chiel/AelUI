local addon = select(2, ...)

local ufConfig = addon.config.unitframes
local round = addon.utils.Round
local size = round(ufConfig.height * 0.4)

local function PostUpdate(element, role)
	if role == 'DAMAGER' then
		element:Hide()
	end
end

function addon.elements.GroupRole(self, unit)
	local groupRole = self:CreateTexture(nil, 'OVERLAY')
	groupRole:SetSize(size, size)
	groupRole.PostUpdate = PostUpdate

	self.GroupRoleIndicator = groupRole
	return groupRole
end
