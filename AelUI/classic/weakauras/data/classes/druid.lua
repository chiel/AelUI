local _, ns = ...

local wa = ns.weakauras
local c = wa.creators
local h = wa.helpers

ns.weakauras.data.classes.druid = {
	name = 'Druid',
	icon = 625999,
	id = 'DRUID',

	groups = {
		reminders = {
			c.composeAura(
				c.auraIcon('player', 'buff', 9913), -- Prowl
				function(icon)
					icon.display:SetCooldown({ inverse = true, text = false })

					icon.triggers:Delete(2)
					local buff = icon.triggers:Get(1)
					buff:SetShow('onActive')
					icon.triggers:AddSpellCooldown(9913, { show = 'onCooldown' })

					local cond = icon.conditions:Add()
					cond:CheckActive(buff, false)
					cond:ChangeColor({ 1, 1, 1, 0.75 })
					cond:ChangeDesaturate(true)
				end
			),
		},
		tracking = {
			c.composeAura(
				c.auraIcon('target', 'debuff', 27011), -- Faerie Fire (Feral)
				function(icon)
					local trigger = icon.triggers:Get(1)
					trigger:SetOwnOnly(nil)
				end
			),
			c.composeAura(
				c.auraIcon('target', 'debuff', { 33983, 33987 }), -- Mangle
				function(icon)
					local trigger = icon.triggers:Get(1)
					trigger:SetOwnOnly(nil)
				end
			),
			c.auraIcon('target', 'debuff', 26998), -- Demoralizing Roar
			c.composeAura(
				c.auraIcon('target', 'debuff', 33745), -- Lacerate
				h.addStacksText
			),
		},
	},
}
