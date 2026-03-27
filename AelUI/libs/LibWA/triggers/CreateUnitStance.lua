local _, ns = ...

ns.triggers.CreateUnitStance = function()
	local aura = {}

	aura.Serialize = function(self)
		local t = {
			type = 'unit',
			event = 'Stance/Form/Aura',
		}

		return { trigger = t, untrigger = {} }
	end

	return aura
end
