local ns = select(2, ...)

ns.core.utils.getSpecRole = function()
	local specIndex = GetSpecialization()
	return GetSpecializationRole(specIndex)
end
