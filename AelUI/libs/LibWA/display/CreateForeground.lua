local _, ns = ...

ns.display.CreateForeground = function()
	local aura = {}

	aura.Serialize = function(self)
		return {
			type = 'subforeground',
		}
	end

	return aura
end
