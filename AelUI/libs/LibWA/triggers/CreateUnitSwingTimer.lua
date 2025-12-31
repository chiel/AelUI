local _, ns = ...

ns.triggers.CreateUnitSwingTimer = function(hand)
	local aura = {
		hand = hand, -- main | off | ranged
	}

	aura.Serialize = function(self)
		local t = {
			type = 'unit',
			event = 'Swing Timer',
			hand = self.hand,
		}

		return { trigger = t, untrigger = {} }
	end

	return aura
end
