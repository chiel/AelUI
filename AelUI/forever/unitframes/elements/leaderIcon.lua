local _, ns = ...

ns.unitframes.elements.leaderIcon = function(f, parent)
	local icon = parent:CreateTexture(nil, 'OVERLAY')

	local function update(self)
		local isLeader = UnitIsGroupLeader(self.unit)
		local isAssist = UnitIsGroupAssistant(self.unit)

		if not issecretvalue(isLeader) and isLeader then
			icon:SetTexture([[Interface\GroupFrame\UI-Group-LeaderIcon]])
			icon:Show()
		elseif not issecretvalue(isAssist) and isAssist then
			icon:SetTexture([[Interface\GroupFrame\UI-Group-AssistantIcon]])
			icon:Show()
		else
			icon:Hide()
		end
	end

	f:RegisterCallback('GROUP_ROSTER_UPDATE', update)
	f:RegisterCallback('PARTY_LEADER_CHANGED', update)

	update(f)

	return icon
end
