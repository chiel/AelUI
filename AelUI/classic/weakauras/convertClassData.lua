local _, ns = ...

local groupTypeOrder = {
	'primary',
}

ns.weakauras.convertClassData = function(classData)
	local classId = 'AelUI - ' .. classData.name
	local classGroup = LibWA.CreateGroup(classId)
	classGroup:SetIcon(classData.icon)

	for _, groupType in ipairs(groupTypeOrder) do
		local typeData = classData.groups[groupType]
		if typeData ~= nil then
			local typeConfig = ns.weakauras.config[groupType]
			local childConfig = typeConfig.childConfig
			local groupConfig = typeConfig.groupConfig

			local typeId = typeConfig.name .. ' (' .. classId .. ')'
			local typeGroup = LibWA.CreateDynamicGroup(typeId)
			typeGroup:SetAnchor(groupConfig.anchor)
			typeGroup:SetGrow(groupConfig.grow)
			classGroup:AddChild(typeGroup)

			local auraSuffix = ' (' .. classId .. ' - ' .. typeConfig.name .. ')'
			for _, createAura in ipairs(typeData) do
				local icon = createAura(auraSuffix, childConfig)
				icon.load:Class(classData.id)
				typeGroup:AddChild(icon)
			end
		end
	end

	return classGroup:Serialize()
end
