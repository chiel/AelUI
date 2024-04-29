local addon = select(2, ...)

addon.classic.weakauras.convertClassData = function(classData)
	local classId = 'AelUI - Class - ' .. classData.name
	local classGroup = LibWA.CreateGroup(classId)
	classGroup:SetIcon(classData.icon)

	for type, group in pairs(classData.groups) do
		local typeConfig = addon.classic.weakauras.config[type]
		if typeConfig == nil then
			addon.console:Printf('No config for group type %s found.', type)
		else
			-- local childConfig = typeConfig.childConfig
			local groupConfig = typeConfig.groupConfig

			local typeId = classId .. ' - ' .. typeConfig.name
			local typeGroup = LibWA.CreateDynamicGroup(typeId)
			typeGroup:SetAnchor(groupConfig.anchor)
			typeGroup:SetGrow(groupConfig.grow)
			classGroup:AddChild(typeGroup)

			for _, aura in ipairs(group) do
				local spellName = ''
				if aura.spellId ~= nil then
					spellName = GetSpellInfo(aura.spellId)
				end

				if aura.debuffId ~= nil then
					spellName = GetSpellInfo(aura.debuffId)
				end

				local iconId = classId .. ' - ' .. spellName
				local icon = typeConfig.createIcon(iconId, classData.class, aura)
				typeGroup:AddChild(icon)
			end
		end
	end

	return classGroup:Serialize()
end
