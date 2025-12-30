local _, ns = ...

local wa = ns.weakauras
local c = wa.creators
local h = wa.helpers

wa.creators.spellIcon = function(spellId)
	return c.composeAura(c.spellIconBase(spellId), h.addProgressText, function(icon)
		local border = icon.display:Get(2)
		local trigger = icon.triggers:Get(1)

		local cond = icon.conditions:Add()
		cond:CheckSpellInRange(trigger, false)
		cond:ChangeBorderColor(border, { 1, 0, 0, 0.75 })
	end)
end
