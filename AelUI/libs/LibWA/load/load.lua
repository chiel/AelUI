local _, ns = ...

ns.load = {}

ns.load.Create = function()
	local aura = {
		conditions = {},
	}

	aura.Serialize = function(self)
		local r = { load = {} }

		return r
	end

	return aura
end
