local _, ns = ...

local wa = ns.weakauras
local c = wa.creators
local h = wa.helpers

wa.creators.spellIcon = function(spellId)
	return c.composeAura(c.spellIconBase(spellId), h.addProgressText)
end
