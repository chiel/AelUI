local _, ns = ...

LibWA.CreateIcon = function(id)
	local aura = {
		base = ns.auras.CreateBase(id),
		display = ns.display.CreateIconOptions(),
	}

	aura.SetParent = function(self, ...)
		self.base:SetParent(...)
	end

	aura.Serialize = function(self)
		local r = self.base:Serialize()
		r.regionType = 'icon'
		return Mixin(r, self.display:Serialize())
	end

	return aura
end
