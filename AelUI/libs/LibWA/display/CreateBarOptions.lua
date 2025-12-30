local _, ns = ...

ns.display.CreateBarOptions = function()
	local aura = {
		subregions = {
			ns.display.CreateBackground(),
			ns.display.CreateForeground(),
		},
	}

	aura.AddBorder = function(self, ...)
		local border = ns.display.CreateBorder(...)
		table.insert(self.subregions, border)
		return border
	end

	aura.SetAnchor = function(self, anchor)
		self.anchor = anchor
	end

	aura.SetBackgroundColor = function(self, color)
		self.backgroundColor = color
	end

	aura.SetBarColor = function(self, color)
		self.barColor = color
	end

	aura.SetSize = function(self, width, height)
		self.size = { width = width, height = height }
	end

	aura.SetTexture = function(self, texture)
		self.texture = texture
	end

	aura.Serialize = function(self)
		local r = {
			subRegions = {},
		}

		if self.anchor ~= nil then
			r.anchorFrameType = self.anchor.type
			r.anchorFrameFrame = self.anchor.frame
			r.anchorPoint = self.anchor.to
			r.selfPoint = self.anchor.from
			r.xOffset = self.anchor.x
			r.yOffset = self.anchor.y
		end

		if self.backgroundColor ~= nil then
			r.backgroundColor = self.backgroundColor
		end

		if self.barColor ~= nil then
			r.barColor = self.barColor
		end

		if self.size ~= nil then
			r.width = self.size.width
			r.height = self.size.height
		end

		if self.texture ~= nil then
			r.texture = self.texture
		end

		for i, subregion in ipairs(self.subregions) do
			subregion.id = i
			table.insert(r.subRegions, subregion:Serialize())
		end

		return r
	end

	return aura
end
