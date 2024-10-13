local _, addon = ...

addon.display.CreateForeground = function()
	local aura = {
		table = {
			type = 'subforeground',
		},
	}

	aura.Serialize = function(self)
		return self.table
	end

	return aura
end
