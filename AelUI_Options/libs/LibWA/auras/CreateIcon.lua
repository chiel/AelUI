local addon = select(2, ...)

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
			aura.display:Serialize(),
			aura.triggers:Serialize(),
			aura.conditions:Serialize(),
			aura.load:Serialize()
		)
	end

	return aura
end
