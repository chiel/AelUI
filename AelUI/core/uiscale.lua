local _, ns = ...

ns.OnEnable(function()
	local _, height = GetPhysicalScreenSize()
	UIParent:SetScale((768 * 1.5) / height)
end)
