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
			c.spellIcon(122), -- Frost Nova
			c.spellIcon(120), -- Cone of Cold
			c.spellIcon(2137), -- Fire Blast
		},
		secondary = {
			c.spellIcon(2139), -- Counterspell
			c.spellIcon(1953), -- Blink
			c.spellIcon(11958), -- Ice Block
		},
	},
}
