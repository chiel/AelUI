local addon = select(2, ...)

addon.display.CreateBorder = function()
	local aura = {}
	local t = {}

	aura.Serialize = function(self)
		return t
	end
end
