local _, addon = ...

LibWA.CreateBar = function(id)
	local aura = {
		base = addon.auras.CreateBase(id),
		animations = addon.animations.Create(),
		conditions = addon.conditions.Create(),
		display = addon.display.CreateBarOptions(),
		load = addon.load.Create(),
		triggers = addon.triggers.Create(),
	}

	aura.SetParent = function(self, ...)
		self.base:SetParent(...)
	end

	aura.Serialize = function(self)
		local r = self.base:Serialize()
		r.regionType = 'aurabar'
		return Mixin(
			r,
			aura.triggers:Serialize(),
			aura.display:Serialize(),
			aura.conditions:Serialize(),
			aura.animations:Serialize(),
			aura.load:Serialize()
		)
	end

	return aura
end
