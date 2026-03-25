local _, ns = ...

local wa = ns.weakauras
local c = wa.creators
local h = wa.helpers

ns.weakauras.data.classes.mage = {
	name = 'Mage',
	icon = 626001,
	id = 'MAGE',

	groups = {
		primary = {
			c.spellIcon(12472), -- Cold Snap
			c.spellIcon(12051), -- Evocation
			c.spellIcon(31687), -- Summon Water Elemental
			c.spellIcon(11958), -- Cold Snap
			c.spellIcon(122), -- Frost Nova
			c.spellIcon(120), -- Cone of Cold
			c.spellIcon(2137), -- Fire Blast
		},
		secondary = {
			c.spellIcon(2139), -- Counterspell
			c.spellIcon(1953), -- Blink
			c.spellIcon(20589), -- Escape Artist
			c.spellIcon(10223), -- Fire Ward
			c.spellIcon(13032), -- Ice Barrier
			c.spellIcon(45438), -- Ice Block
		},
	},
}
