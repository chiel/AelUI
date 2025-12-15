local _, ns = ...

ns.conditions = {}

ns.conditions.Create = function()
	local aura = {
		conditions = {},
	}

	aura.Serialize = function(self)
		local r = { conditions = {} }

		return r
	end

	return aura
end
