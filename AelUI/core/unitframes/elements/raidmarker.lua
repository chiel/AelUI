local _, ns = ...

ns.unitframes.elements.raidmarker = function(f, parent, options)
	local o = options or {}
	local size = o.size or 20

	local icon = parent:CreateTexture(nil, 'OVERLAY')
	icon:SetTexture([[Interface\TargetingFrame\UI-RaidTargetingIcons]])
	icon:SetSize(size, size)

	local function update(self)
		local index = GetRaidTargetIndex(self.unit)
		if index then
			SetRaidTargetIconTexture(icon, index)
			icon:Show()
		else
			icon:Hide()
		end
	end

	f:RegisterCallback('RAID_TARGET_UPDATE', update)

	update(f)

	return icon
end
