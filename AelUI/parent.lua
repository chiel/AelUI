local _, ns = ...

CreateFrame('Frame', 'AelUIParent', UIParent)
AelUIParent:SetFrameLevel(2)

local function updateScale()
	local width, height = GetPhysicalScreenSize()
	local targetScale = 768 / height
	local parentScale = UIParent:GetEffectiveScale()

	AelUIParent:SetScale(targetScale / parentScale)
	AelUIParent:SetAllPoints(UIParent)
end

AelUIParent:RegisterEvent('DISPLAY_SIZE_CHANGED')
AelUIParent:RegisterEvent('UI_SCALE_CHANGED')
AelUIParent:SetScript('OnEvent', updateScale)
