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

	aura.AddGlow = function(self, ...)
		local glow = ns.display.CreateGlow(...)
		table.insert(self.subregions, glow)
		return glow
	end

	aura.AddText = function(self, ...)
		local text = ns.display.CreateText(...)
		table.insert(self.subregions, text)
		return text
	end

	aura.Get = function(self, index)
		return self.subregions[index]
	end

	aura.SetColor = function(self, color)
		self.color = color
	end

	aura.SetCooldown = function(self, cooldown)
		self.cooldown = cooldown
	end

	aura.SetDesaturate = function(self, value)
		self.desaturate = value
	end

	aura.SetKeepAspectRatio = function(self, value)
		self.keepAspectRatio = value
	end

	aura.SetSize = function(self, width, height)
		self.size = { width = width, height = height }
	end

	aura.Serialize = function(self)
		local r = {
			cooldown = false,
			subRegions = {},
		}

		if self.color ~= nil then
			r.color = self.color
		end

		if self.desaturate ~= nil then
			r.desaturate = self.desaturate
		end

		if self.keepAspectRatio ~= nil then
			r.keepAspectRatio = self.keepAspectRatio
		end

		if self.size ~= nil then
			r.width = self.size.width
			r.height = self.size.height
		end

		local cd = self.cooldown
		if cd ~= nil and cd ~= false then
			r.cooldown = true
			r.cooldownEdge = cd.edge or false
			r.cooldownSwipe = cd.swipe ~= nil and cd.swipe or true
			r.cooldownTextDisabled = cd.text == false
			r.inverse = cd.inverse or false
		end

		for i, subregion in ipairs(self.subregions) do
			subregion.id = i
			table.insert(r.subRegions, subregion:Serialize())
		end

		return r
	end

	return aura
end
