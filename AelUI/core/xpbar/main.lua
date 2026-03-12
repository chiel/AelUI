local _, ns = ...

local s = ns.xpbar

local function render()
	s.render(s.getData())
end

local handler = CreateFrame('Frame')
handler:RegisterEvent('PLAYER_LEVEL_UP')
handler:RegisterEvent('PLAYER_XP_UPDATE')
handler:RegisterEvent('UPDATE_EXHAUSTION')
handler:SetScript('OnEvent', function()
	render()
end)

ns.OnEnable(function()
	render()
end)
