local _, ns = ...

ns.OnEnable(function()
	local _, height = GetPhysicalScreenSize()
	UIParent:SetScale(768 / height)
end)
