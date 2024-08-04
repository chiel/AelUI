local _, addon = ...

addon.display = {}

addon.display.Create = function()
	local aura = {
		subRegions = {
			addon.display.CreateBackground(),
		},
	}

	aura.AddBorder = function(self, ...)
		local border = addon.display.CreateBorder(...)
		table.insert(self.subRegions, border)
		return border
	end

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

	aura.Delete = function(self, index)
		local newRegions = {}
		for i, sr in ipairs(self.subRegions) do
			if i ~= index then
				table.insert(newRegions, sr)
			end
		end

		self.subRegions = newRegions
	end

	aura.GetSubRegion = function(self, index)
		return self.subRegions[index]
	end

	aura.Move = function(self, subregion, layer)
		local newRegions = {}
		for i, sr in ipairs(self.subRegions) do
			if sr ~= subregion then
				if i == layer then
					table.insert(newRegions, subregion)
				end

				table.insert(newRegions, sr)
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

	aura.SetIcon = function(self, source)
		if source == nil or source == 'automatic' then
			self.icon = nil
		else
			self.icon = source
		end
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

		if self.icon ~= nil then
			if type(self.icon) == 'number' then
				r.iconSource = 0
				r.displayIcon = self.icon
			else
				r.iconSource = self.icon.id
			end
		end

		if self.keepAspectRatio ~= nil then
			r.keepAspectRatio = self.keepAspectRatio
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
