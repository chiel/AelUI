local addon = select(2, ...)

addon.display.CreateBackground = function()
	local aura = {
		table = {
			type = 'subbackground',
		},
	}

	aura.Serialize = function(self)
		return self.table
	end

	return aura
end
