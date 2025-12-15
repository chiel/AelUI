local _, ns = ...

LibWA.CreateIcon = function(id)
	local aura = {
		base = ns.auras.CreateBase(id),
		animations = ns.animations.Create(),
		conditions = ns.conditions.Create(),
		display = ns.display.CreateIconOptions(),
		triggers = ns.triggers.Create(),
	}

	aura.SetParent = function(self, ...)
		self.base:SetParent(...)
	end

	aura.Serialize = function(self)
		local r = self.base:Serialize()
		r.regionType = 'icon'

		return Mixin(
			r,
			self.triggers:Serialize(),
			self.display:Serialize(),
			self.conditions:Serialize(),
			self.animations:Serialize()
		)
	end

	return aura
end
