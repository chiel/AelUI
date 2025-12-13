local _, ns = ...

ns.display.CreateIconOptions = function()
	local aura = {
		subregions = {
			ns.display.CreateBackground(),
		},
	}

	aura.Serialize = function(self)
		local r = {
			cooldown = false,
			subRegions = {},
		}

		return r
	end

	return aura
end
