local ns = select(2, ...)

ns.weakauras.convertClassData = function(classData)
	local classId = 'AelUI - ' .. classData.name
	local classGroup = LibWA.CreateGroup(classId)
	classGroup:SetIcon(classData.icon)

	for _, specData in ipairs(classData.specs) do
		local specId = classId .. ' - ' .. specData.name
		local specGroup = LibWA.CreateGroup(specId)
		specGroup:SetIcon(specData.icon)
		classGroup:AddChild(specGroup)

		for groupType, typeData in pairs(specData.groups) do
			local typeConfig = ns.weakauras.config[groupType]
			if typeConfig == nil then
				ns.options.console:Printf('No config for group type %s found.', groupType)
			else
				local childConfig = typeConfig.childConfig
				local groupConfig = typeConfig.groupConfig

				local typeId = specId .. ' - ' .. typeConfig.name
				local typeGroup = LibWA.CreateDynamicGroup(typeId)
				typeGroup:SetAnchor(groupConfig.anchor)
				typeGroup:SetGrow(groupConfig.grow)
				specGroup:AddChild(typeGroup)

				for _, createIcon in ipairs(typeData) do
					local icon = createIcon(specId, childConfig)
					icon.load:ClassAndSpec(specData.specId)
					typeGroup:AddChild(icon)
				end
			end
		end
	end

	return classGroup:Serialize()
end
