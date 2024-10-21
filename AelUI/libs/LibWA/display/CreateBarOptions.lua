local _, addon = ...

addon.display.CreateBarOptions = function()
	local aura = {
		subRegions = {
			addon.display.CreateBackground(),
			addon.display.CreateForeground(),
		},
	}

	aura.AddBorder = function(self, ...)
		local border = addon.display.CreateBorder(...)
		table.insert(self.subRegions, border)
		return border
	end

	-- aura.AddGlow = function(self, ...)
	-- 	local glow = addon.display.CreateGlow(...)
	-- 	table.insert(self.subRegions, glow)
	-- 	return glow
	-- end

	-- aura.AddText = function(self, ...)
	-- 	local text = addon.display.CreateText(...)
	-- 	table.insert(self.subRegions, text)
	-- 	return text
	-- end

	-- aura.Delete = function(self, index)
	-- 	local newRegions = {}
	-- 	for i, sr in ipairs(self.subRegions) do
	-- 		if i ~= index then
	-- 			table.insert(newRegions, sr)
	-- 		end
	-- 	end

	-- 	self.subRegions = newRegions
	-- end

	-- aura.GetSubRegion = function(self, index)
	-- 	return self.subRegions[index]
	-- end

	-- aura.Move = function(self, subregion, layer)
	-- 	local newRegions = {}
	-- 	for i, sr in ipairs(self.subRegions) do
	-- 		if sr ~= subregion then
	-- 			if i == layer then
	-- 				table.insert(newRegions, subregion)
	-- 			end

	-- 			table.insert(newRegions, sr)
	-- 		end
	-- 	end

	-- 	self.subRegions = newRegions
	-- end

	aura.SetAnchor = function(self, anchor)
		self.anchor = anchor
	end

	aura.SetBackgroundColor = function(self, color)
		self.backgroundColor = color
	end

	aura.SetBarColor = function(self, color)
		self.barColor = color
	end

	-- aura.SetCooldown = function(self, cooldown)
	-- 	self.cooldown = cooldown
	-- end

	-- aura.SetDesaturate = function(self, value)
	-- 	self.desaturate = value
	-- end

	-- aura.SetIcon = function(self, source)
	-- 	if source == nil or source == 'automatic' then
	-- 		self.icon = nil
	-- 	else
	-- 		self.icon = source
	-- 	end
	-- end

	aura.SetSize = function(self, width, height)
		self.size = { width = width, height = height }
	end

	aura.SetTexture = function(self, texture)
		self.texture = texture
	end

	aura.Serialize = function(self)
		local r = {
			-- cooldown = false,
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

		-- if self.desaturate ~= nil then
		-- 	r.desaturate = self.desaturate
		-- end

		-- if self.icon ~= nil then
		-- 	if type(self.icon) == 'number' then
		-- 		r.iconSource = 0
		-- 		r.displayIcon = self.icon
		-- 	else
		-- 		r.iconSource = self.icon.id
		-- 	end
		-- end

		-- if self.keepAspectRatio ~= nil then
		-- 	r.keepAspectRatio = self.keepAspectRatio
		-- end

		if self.size ~= nil then
			Mixin(r, self.size)
		end

		-- if self.cooldown ~= nil then
		-- 	r.cooldown = true
		-- 	r.cooldownEdge = self.cooldown.edge or false
		-- 	r.cooldownSwipe = self.cooldown.swipe ~= nil and self.cooldown.swipe or true
		-- 	r.cooldownTextDisabled = self.cooldown.text or true
		-- 	r.inverse = self.cooldown.inverse or false
		-- end

		if self.texture ~= il then
			r.texture = self.texture
		end

		for i, subRegion in ipairs(self.subRegions) do
			subRegion.id = i
			table.insert(r.subRegions, subRegion:Serialize())
		end

		return r
	end

	return aura
end
