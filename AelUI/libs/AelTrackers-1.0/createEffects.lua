local lib = LibStub('AelTrackers-1.0')

local Effects = {}
Effects.__index = Effects

lib.createEffects = function()
	return setmetatable({ effects = {} }, Effects)
end

function Effects:Add()
	local effect = lib.createEffect()
	tinsert(self.effects, effect)
	return effect
end

function Effects:Apply(tracker)
	for _, effect in ipairs(self.effects) do
		if effect:Matches() then
			effect:Apply(tracker)
		end
	end
end
