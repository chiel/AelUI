local _, addon = ...

LibWA.CreateIcon = function(id)
	local aura = {
		base = addon.auras.CreateBase(id),
		conditions = addon.conditions.Create(),
		display = addon.display.Create(),
		load = addon.load.Create(),
		triggers = addon.triggers.Create(),
	}

	aura.SetParent = function(self, ...)
		self.base:SetParent(...)
	end

	aura.Serialize = function(self)
		local r = self.base:Serialize()
		r.regionType = 'icon'
		return Mixin(
			r,
			aura.triggers:Serialize(),
			aura.display:Serialize(),
			aura.conditions:Serialize(),
			aura.load:Serialize()
		)
	end

	return aura
end
