local _, ns = ...

ns.display.CreateIconOptions = function()
	local aura = {
		subregions = {
			ns.display.CreateBackground(),
		},
	}

	aura.AddBorder = function(self, ...)
		local border = ns.display.CreateBorder(...)
		table.insert(self.subregions, border)
		return border
	end

	aura.SetSize = function(self, width, height)
		self.size = { width = width, height = height }
	end

	aura.Serialize = function(self)
		local r = {
			cooldown = false,
			subRegions = {},
		}

		if self.size ~= nil then
			r.width = self.size.width
			r.height = self.size.height
		end

		for i, subregion in ipairs(self.subregions) do
			subregion.id = i
			table.insert(r.subRegions, subregion:Serialize())
		end

		return r
	end

	return aura
end
