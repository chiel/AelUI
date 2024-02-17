local addon = select(2, ...)

addon.display = {}

addon.display.Create = function()
	local aura = {
		subRegions = {
			addon.display.CreateBackground(),
		},
	}

	aura.AddGlow = function(self, ...)
		local glow = addon.display.CreateGlow(...)
		table.insert(self.subRegions, glow)
		return glow
	end

	aura.AddText = function(self, ...)
		local text = addon.display.CreateText(...)
		table.insert(self.subRegions, text)
		return text
	end

	aura.MoveToBackground = function(self, subregion)
		local newRegions = {}
		for i, sr in ipairs(self.subRegions) do
			if sr ~= subregion then
				table.insert(newRegions, sr)
			end

			if i == 1 then
				table.insert(newRegions, subregion)
			end
		end

		self.subRegions = newRegions
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

		if self.size ~= nil then
			Mixin(r, self.size)
		end

		if self.cooldown ~= nil then
			r.cooldown = true
			r.cooldownEdge = self.cooldown.edge or false
			r.cooldownSwipe = self.cooldown.swipe ~= nil and self.cooldown.swipe or true
			r.cooldownTextDisabled = self.cooldown.text or true
			r.inverse = self.cooldown.inverse or false
		end

		for i, subRegion in ipairs(self.subRegions) do
			subRegion.id = i
			table.insert(r.subRegions, subRegion:Serialize())
		end

		return r
	end

	return aura
end
