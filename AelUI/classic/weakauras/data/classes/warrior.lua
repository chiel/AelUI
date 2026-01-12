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
			c.spellIcon(12292), -- Sweeping Strikes
			c.spellIcon(2687), -- Bloodrage
			c.composeAura(
				c.spellIcon(7384), -- Overpower
				function(icon)
					icon.display:SetColor({ 1, 1, 1, 0.75 })
					icon.display:SetDesaturate(true)

					local glow = icon.display:AddGlow('button')
					icon.display:Move(glow, 3)

					icon.triggers:SetActivateOn('any')
					local usable = icon.triggers:AddSpellUsable(7384, { ignoreCooldown = true })

					local cond = icon.conditions:Add()
					cond:CheckActive(usable, true)
					cond:ChangeColor({ 1, 1, 1, 1 })
					cond:ChangeDesaturate(false)
					cond:ChangeGlowVisibility(glow, true)

					icon.conditions:Move(cond, 1)
				end
			),
			c.composeAura(
				c.spellIcon(6574), -- Revenge
				function(icon)
					icon.display:SetColor({ 1, 1, 1, 0.75 })
					icon.display:SetDesaturate(true)

					local glow = icon.display:AddGlow('button')
					icon.display:Move(glow, 3)

					icon.triggers:SetActivateOn('any')
					local usable = icon.triggers:AddSpellUsable(6574, { ignoreCooldown = true })

					local cond = icon.conditions:Add()
					cond:CheckActive(usable, true)
					cond:ChangeColor({ 1, 1, 1, 1 })
					cond:ChangeDesaturate(false)
					cond:ChangeGlowVisibility(glow, true)

					icon.conditions:Move(cond, 1)
				end
			),
			c.spellIcon(8198), -- Thunder Clap
			c.spellIcon(2565), -- Shield Block
		},
		secondary = {
			c.spellIcon(72), -- Shield Bash
			c.spellIcon(676), -- Disarm
			c.spellIcon(5246), -- Intimidating Shout
			c.spellIcon(100), -- Charge
			c.spellIcon(20616), -- Charge
			c.spellIcon(20230), -- Retaliation
			c.spellIcon(694), -- Mocking Blow
			c.spellIcon(355), -- Taunt
		},
		tracking = {
			c.auraIcon('target', 'debuff', 8205), -- Thunder Clap
			c.auraIcon('target', 'debuff', 11555), -- Demoralizing Shout
			c.composeAura(
				c.auraIcon('target', 'debuff', 8380), -- Sunder Armor
				h.addStacksText
			),
			c.auraIcon('target', 'debuff', 11572), -- Rend
		},
	},
}
