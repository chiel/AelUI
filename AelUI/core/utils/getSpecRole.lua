local addon = select(2, ...)

addon.core.utils.getSpecRole = function()
	local specIndex = GetSpecialization()
	return GetSpecializationRole(specIndex)
end
