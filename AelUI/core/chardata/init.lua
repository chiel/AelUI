local _, ns = ...

local charName = UnitName('player')
local charRealm = GetRealmName()
local charKey = charName .. ' - ' .. charRealm
local _, charClass = UnitClass('player')

ns.chardata = {
	charName = charName,
	charRealm = charRealm,
	charKey = charKey,
	charClass = charClass,
}

ns.OnInitialise(function()
	if not ns.db.global.characters then ns.db.global.characters = {} end
	if not ns.db.global.characters[charKey] then ns.db.global.characters[charKey] = {} end

	local char = ns.db.global.characters[charKey]
	char.name = charName
	char.realm = charRealm
	char.class = charClass
end)
