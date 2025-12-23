local _, ns = ...

LibWA.CreateDynamicGroup = function(id)
	local aura = {
		base = ns.auras.CreateGroupBase(id),
		spacing = 2,
	}

	aura.AddChild = function(self, ...)
		self.base:AddChild(...)
	end

	aura.SetAnchor = function(self, ...)
		self.base:SetAnchor(...)
	end

	aura.SetGrow = function(self, grow)
		self.grow = grow
	end

	aura.SetIcon = function(self, ...)
		self.base:SetIcon(...)
	end

	aura.SetParent = function(self, ...)
		self.base:SetParent(...)
	end

	aura.SetSpacing = function(self, spacing)
		aura.spacing = spacing
	end

	aura.Serialize = function(self)
		local r, rc = self.base:Serialize()
		r.regionType = 'dynamicgroup'
		r.space = self.spacing

		if self.grow ~= nil then
			r.grow = self.grow.type
			r.growOn = self.grow.on
			r.customGrow = self.grow.custom
			r.align = self.grow.align
		end

		return r, rc
	end

	return aura
end
