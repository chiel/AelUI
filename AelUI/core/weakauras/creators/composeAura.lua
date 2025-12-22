local _, ns = ...

local wa = ns.weakauras

wa.creators.composeAura = function(creator, ...)
	local mods = { ... }

	return function(idSuffix, config)
		local aura = creator(idSuffix, config)

		for _, fn in ipairs(mods) do
			local result = fn(aura)
			if result ~= nil then
				aura = result
			end
		end

		return aura
	end
end
