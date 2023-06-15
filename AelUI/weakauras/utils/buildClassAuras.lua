local addon = select(2, ...)

local u = addon.weakauras.utils

local internalVersion = 65

addon.weakauras.utils.buildClassAuras = function(data)
	local classAuraId = 'AelUI - Class - ' .. data.name
	local classAura = {
		internalVersion = internalVersion,
		regionType = 'group',
		id = classAuraId,
		uid = classAuraId,
		groupIcon = data.icon,
		controlledChildren = {},
	}

	local childAuras = {}

	for _, spec in ipairs(data.specs) do
		local specAuraId = 'AelUI - Class - ' .. data.name .. ' - ' .. spec.name
		local specAura = u.buildSpecAura(spec)
		specAura.internalVersion = internalVersion
		specAura.id = specAuraId
		specAura.uid = specAuraId
		specAura.parent = classAuraId

		table.insert(childAuras, specAura)
		table.insert(classAura.controlledChildren, specAuraId)

		for _, group in ipairs(spec.groups) do
			local groupAuraId = 'AelUI - Class - ' .. data.name .. ' - ' .. spec.name .. ' - ' .. group.name
			local groupAura = u.buildGroupAura(group)
			groupAura.internalVersion = internalVersion
			groupAura.id = groupAuraId
			groupAura.uid = groupAuraId
			groupAura.parent = specAuraId

			table.insert(childAuras, groupAura)
			table.insert(specAura.controlledChildren, groupAuraId)

			for _, icon in ipairs(group.icons) do
				local auraId = 'AelUI - Class - ' .. data.name .. ' - ' .. ' - ' .. spec.name .. ' - ' .. icon.name
				local aura = u.buildSpellIconAura(icon, group.type)
				aura.internalVersion = internalVersion
				aura.id = auraId
				aura.uid = auraId
				aura.parent = groupAuraId

				aura.load = {
					class_and_spec = {
						single = spec.specId,
					},
					use_class_and_spec = true,
				}

				table.insert(childAuras, aura)
				table.insert(groupAura.controlledChildren, auraId)
			end
		end
	end

	return classAura, childAuras
end