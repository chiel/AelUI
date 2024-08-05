local _, ns = ...

local groupTypeOrder = {
	'primary',
	'secondary',
	'tracking',
	'defensives',
	'consumables',
}

ns.weakauras.convertClassData = function(classData)
	local classId = 'AelUI - ' .. classData.name
	local classGroup = LibWA.CreateGroup(classId)
	classGroup:SetIcon(classData.icon)

	for _, specData in ipairs(classData.specs) do
		local _, specName, _, specIcon = GetSpecializationInfoByID(specData.specId)
		local specId = classId .. ' - ' .. specName
		local specGroup = LibWA.CreateGroup(specId)
		specGroup:SetIcon(specIcon)
		classGroup:AddChild(specGroup)

		for _, groupType in ipairs(groupTypeOrder) do
			local typeData = specData.groups[groupType]
			if typeData ~= nil then
				local typeConfig = ns.weakauras.config[groupType]
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
