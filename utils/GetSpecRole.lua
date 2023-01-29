local addon = select(2, ...)

addon.utils.GetSpecRole = function()
	local specIndex = GetSpecialization()
	return GetSpecializationRole(specIndex)
end
