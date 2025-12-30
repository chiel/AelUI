local _, ns = ...

ns.weakauras.convertCommonData = function(data)
	local commonId = 'AelUI - Common'
	local commonGroup = LibWA.CreateGroup(commonId)
	commonGroup:SetIcon(135740)

	local auraSuffix = ' (' .. commonId .. ')'
	for _, createAura in ipairs(data) do
		local aura = createAura(auraSuffix)
		commonGroup:AddChild(aura)
	end

	return commonGroup:Serialize()
end
