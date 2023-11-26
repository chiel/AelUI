local addon = select(2, ...)

local function ScaleKeystoneFrame()
	local ckf = ChallengesKeystoneFrame
	ckf:SetScale(0.75)
	ckf:ClearAllPoints()
	ckf:SetPoint('BOTTOM', addon.uiAnchor, 'TOP', 0, 120)
end

local f = CreateFrame('Frame')
f:SetScript('OnEvent', function(self, event, name)
	if name == 'Blizzard_ChallengesUI' then
		ChallengesKeystoneFrame:HookScript('OnShow', ScaleKeystoneFrame)
	end
end)
f:RegisterEvent('ADDON_LOADED')
