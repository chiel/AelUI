local _, addon = ...

LibWA.CreateIcon = function(id)
	local aura = {
		base = addon.auras.CreateBase(id),
		animations = addon.animations.Create(),
		conditions = addon.conditions.Create(),
		display = addon.display.CreateIconOptions(),
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
			aura.animations:Serialize(),
			aura.load:Serialize()
		)
	end

	return aura
end
