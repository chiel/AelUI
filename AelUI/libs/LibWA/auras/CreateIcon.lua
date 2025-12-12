local _, ns = ...

LibWA.CreateIcon = function(id)
	local aura = {
		base = ns.auras.CreateBase(id),
	}

	aura.SetParent = function(self, ...)
		self.base:SetParent(...)
	end

	aura.Serialize = function(self)
		local r = self.base:Serialize()
		r.regionType = 'icon'
		return r
	end

	return aura
end
