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
			c.auraIcon('target', 'debuff', 17392), -- Faerie Fire (Feral)
			c.auraIcon('target', 'debuff', 9904), -- Rake
			c.auraIcon('target', 'debuff', 9894), -- Rip
		},
	},
}
