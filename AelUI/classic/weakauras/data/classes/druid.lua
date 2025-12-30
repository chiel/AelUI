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
				c.auraIcon('player', 'buff', 6783), -- Prowl
				function(icon)
					icon.display:SetCooldown({ inverse = true, text = false })

					icon.triggers:SetActivateOn('any')
					local buff = icon.triggers:Get(1)
					buff:SetShow('onActive')
					icon.triggers:AddSpellCooldown(6783, { show = 'onCooldown' })

					local cond = icon.conditions:Add()
					cond:CheckActive(buff, false)
					cond:ChangeColor({ 1, 1, 1, 0.75 })
					cond:ChangeDesaturate(true)
				end
			),
		},
	},
}
