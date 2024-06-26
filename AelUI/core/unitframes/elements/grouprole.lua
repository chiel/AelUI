local ns = select(2, ...)

local function PostUpdate(element, role)
	if role == 'DAMAGER' then
		element:Hide()
	end
end

ns.unitframes.elements.groupRole = function(self, unit)
	local groupRole = self:CreateTexture(nil, 'OVERLAY')
	groupRole:SetSize(16, 16)
	groupRole.PostUpdate = PostUpdate

	self.GroupRoleIndicator = groupRole
	return groupRole
end
