local _, addon = ...

LibWA.CreateGroup = function(id)
	local aura = {
		base = addon.auras.CreateGroupBase(id),
	}

	aura.AddChild = function(self, ...)
		self.base:AddChild(...)
	end

	aura.SetAnchor = function(self, ...)
		self.base:SetAnchor(...)
	end

	aura.SetIcon = function(self, ...)
		self.base:SetIcon(...)
	end

	aura.SetParent = function(self, ...)
		self.base:SetParent(...)
	end

	aura.Serialize = function(self)
		local r, rc = self.base:Serialize()
		r.regionType = 'group'

		return r, rc
	end

	return aura
end
