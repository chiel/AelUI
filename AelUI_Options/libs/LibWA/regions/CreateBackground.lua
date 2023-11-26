local addon = select(2, ...)

addon.regions.CreateBackground = function()
	local aura = {
		table = {
			type = 'subbackground',
		},
	}

	aura.Serialize = function(self)
		return self.table
	end
end
