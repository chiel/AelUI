local _, ns = ...

CreateFrame('Frame', 'AelUIParent')
AelUIParent:SetAllPoints()
AelUIParent:SetFrameLevel(2)

ns.OnEnable(function()
	local _, height = GetPhysicalScreenSize()
	AelUIParent:SetScale(768 / height)
end)
