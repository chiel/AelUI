local _, ns = ...

ns.OnEnable(function()
	local _, height = GetPhysicalScreenSize()
	UIParent:SetScale((768 * 2) / height)

	MainMenuBar:SetScale(0.75)
end)
