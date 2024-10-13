local _, ns = ...

ns.weakauras.convertCommonData = function(data)
	local commonId = 'AelUI - Common'
	local commonGroup = LibWA.CreateGroup(commonId)
	commonGroup:SetIcon(135740)

	for _, createAura in ipairs(data) do
		local aura = createAura(commonId)
		commonGroup:AddChild(aura)
	end

	return commonGroup:Serialize()
end
