local _, ns = ...

for i = 1, NUM_CHAT_WINDOWS do
	local f = _G['ChatFrame' .. i]
	local font, size = f:GetFont()
	f:SetFont(font, size, 'OUTLINE')
end
