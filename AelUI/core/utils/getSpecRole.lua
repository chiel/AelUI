local ns = select(2, ...)

ns.utils.getSpecRole = function()
	local specIndex = GetSpecialization()
	return GetSpecializationRole(specIndex)
end
