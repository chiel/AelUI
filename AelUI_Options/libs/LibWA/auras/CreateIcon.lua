local addon = select(2, ...)

LibWA.CreateIcon = function(id)
	local aura = addon.auras.CreateBase(id)
	aura.table.regionType = 'icon'
	aura.subRegions = {
		addon.regions.CreateBackground(),
	}

	aura.SetSize = function(self, width, height)
		aura.table.width = width
		aura.table.height = height
	end

	aura.AddCooldown = function(self, options)
		options = options or {}
		aura.table.cooldown = true
		aura.table.cooldownEdge = false
		aura.table.cooldownSwipe = true
		aura.table.cooldownTextDisabled = true
		aura.table.inverse = true
	end

	aura.AddGlow = function(self)
		local glow = addon.regions.CreateGlow()
		table.insert(self.subRegions, glow)
		return glow
	end

	aura.Serialize = function(self)
		local t = aura.table
		t.subRegions = {}

		for _, subRegion in ipairs(self.subRegions) do
			table.insert(t.subRegions, subRegion:Serialize())
		end

		return t
	end

	return aura
end
