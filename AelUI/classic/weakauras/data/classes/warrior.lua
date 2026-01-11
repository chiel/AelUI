local _, ns = ...

local wa = ns.weakauras
local c = wa.creators
local h = wa.helpers

ns.weakauras.data.classes.warrior = {
	name = 'Warrior',
	icon = 626008,
	id = 'WARRIOR',

	groups = {
		primary = {
			c.spellIcon(2687), -- Bloodrage
			c.spellIcon(8198), -- Thunder Clap
			c.spellIcon(7384), -- Overpower
			c.spellIcon(12292), -- Sweeping Strikes
			c.spellIcon(6574), -- Revenge
			c.spellIcon(2565), -- Shield Block
		},
		secondary = {
			c.spellIcon(72), -- Shield Bash
			c.spellIcon(676), -- Disarm
			c.spellIcon(5246), -- Intimidating Shout
			c.spellIcon(100), -- Charge
			c.spellIcon(20230), -- Retaliation
			c.spellIcon(694), -- Mocking Blow
			c.spellIcon(355), -- Taunt
		},
		tracking = {
			c.auraIcon('target', 'debuff', 8205), -- Thunder Clap
			c.auraIcon('target', 'debuff', 11554), -- Demoralizing Shout
			c.composeAura(
				c.auraIcon('target', 'debuff', 8380), -- Sunder Armor
				h.addStacksText
			),
			c.auraIcon('target', 'debuff', 11572), -- Rend
		},
	},
}
