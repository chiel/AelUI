local _, ns = ...

ns.display.CreateBackground = function()
	local aura = {}

	aura.Serialize = function(self)
		return {
			type = 'subbackground',
		}
	end

	return aura
end
