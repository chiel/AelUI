local _, ns = ...

LibWA.CreateBar = function(id)
	local aura = {
		base = ns.auras.CreateBase(id),
		animations = ns.animations.Create(),
		conditions = ns.conditions.Create(),
		display = ns.display.CreateBarOptions(),
		load = ns.load.Create(),
		triggers = ns.triggers.Create(),
	}

	aura.SetParent = function(self, ...)
		self.base:SetParent(...)
	end

	aura.Serialize = function(self)
		local r = self.base:Serialize()
		r.regionType = 'aurabar'

		return Mixin(
			r,
			self.triggers:Serialize(),
			self.display:Serialize(),
			self.conditions:Serialize(),
			self.animations:Serialize(),
			self.load:Serialize()
		)
	end

	return aura
end
