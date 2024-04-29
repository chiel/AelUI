local addon = select(2, ...)

addon.classic.weakauras.config.tracking = {
	name = 'Tracking',
	groupConfig = {
		anchor = {
			type = 'SELECTFRAME',
			frame = 'AelUIPrimaryAnchor',
			from = 'BOTTOM',
			to = 'TOP',
			y = 24,
		},
		grow = {
			type = 'HORIZONTAL',
			align = 'RIGHT',
		},
	},
	createIcon = function(id, class, aura)
		local icon = LibWA.CreateIcon(id)
		icon.display:SetSize(32, 32)

		icon.display:SetCooldown({ inverse = false })

		icon.display:AddText('%p', {
			font = 'AelUI Bold',
			size = 14,
			justify = 'CENTER',
			anchor = {
				from = 'BOTTOM',
				to = 'BOTTOM',
				x = 0,
				y = -1,
			},
			format = {
				dynamic_threshold = 0,
			},
		})

		local trigger

		if aura.debuffId ~= nil then
			trigger = icon.triggers:AddAura('target', 'debuff', {
				exactSpellIds = { aura.debuffId },
				ownOnly = true,
				show = 'always',
			})
		end

		if trigger ~= nil then
			local cond = icon.conditions:Add()
			cond:CheckAuraFound(trigger, false)
			cond:ChangeColor({ 1, 1, 1, 0.5 })
			cond:ChangeDesaturate(true)
		end

		icon.load:Class(class)

		if aura.custom ~= nil then
			local override = aura.custom(icon)
			if override ~= nil then
				icon = override
			end
		end

		return icon
	end,
}
