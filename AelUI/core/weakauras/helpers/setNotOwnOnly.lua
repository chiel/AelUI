local _, ns = ...

local wa = ns.weakauras
local m = ns.media

wa.helpers.setNotOwnOnly = function(icon)
	local t = icon.triggers:Get(1)
	t:SetOwnOnly(nil)
end
