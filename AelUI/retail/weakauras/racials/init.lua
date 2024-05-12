local ns = select(2, ...)

local m = ns.media
local wa = ns.weakauras
local spellIcon = wa.createSpellIconBuilder

ns.weakauras.racials = {
	arcaneTorrent = spellIcon(129597),
}
