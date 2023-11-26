local addon = select(2, ...)

addon.regions.CreateGlow = function()
	local aura = {
		table = {
			type = 'subglow',
			glow = false,
			glowType = 'Proc',
		},
	}

	aura.Serialize = function(self)
		return self.table
	end

	return aura
end
