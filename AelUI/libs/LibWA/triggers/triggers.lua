local _, ns = ...

ns.triggers = {}

ns.triggers.Create = function()
	local aura = {
		triggers = {},
	}

	aura.Serialize = function(self)
		local r = { triggers = {} }

		return r
	end

	return aura
end
