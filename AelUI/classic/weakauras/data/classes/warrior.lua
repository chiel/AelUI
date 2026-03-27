local _, ns = ...

local wa = ns.weakauras
local c = wa.creators
local h = wa.helpers

ns.weakauras.data.classes.warrior = {
	name = 'Warrior',
	icon = 626008,
	id = 'WARRIOR',

	groups = {
		reminders = {
			c.composeAura(c.auraIcon('player', 'buff', 25289), h.setNotOwnOnly, function(icon)
				local t = icon.triggers:Get(1)
				t:SetShow('onMissing')
				icon.triggers:Delete(2)
			end),
		},
		primary = {
			-- melee
			-- heroic strike / cleave
			-- collapse overpower / revenge
			-- collapse shield bash / pummel
			c.spellIcon(12328), -- Sweeping Strikes
			c.spellIcon(2687), -- Bloodrage
			c.spellIcon(23924), -- Shield Slam
			c.spellIcon(23881), -- Bloodthirst
			c.spellIcon(1680), -- Whirlwind
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
			c.spellIcon(6552), -- Pummel
			c.spellIcon(72), -- Shield Bash
			c.spellIcon(676), -- Disarm
			c.spellIcon(5246), -- Intimidating Shout
			c.spellIcon(11556), -- Demoralizing Shout
			c.spellIcon(100), -- Charge
			c.spellIcon(20617), -- Intercept
			c.spellIcon(18499), -- Berserker Rage
			c.spellIcon(20230), -- Retaliation
			c.spellIcon(694), -- Mocking Blow
			c.spellIcon(355), -- Taunt
		},
		tracking = {
			c.composeAura(
				c.auraIcon('target', 'debuff', 11581), -- Thunder Clap
				h.setNotOwnOnly
			),
			c.composeAura(
				c.auraIcon('target', 'debuff', 25202), -- Demoralizing Shout
				h.setNotOwnOnly
			),
			function(idSuffix, config)
				local id = 'Stance' .. idSuffix
				local icon = h.icon(id, config)
				icon.triggers:AddUnitStance()
				return icon
			end,
			c.composeAura(
				c.auraIcon('target', 'debuff', 11597), -- Sunder Armor
				h.addStacksText,
				h.setNotOwnOnly
			),
			c.auraIcon('target', 'debuff', 11572), -- Rend
		},
	},
}
