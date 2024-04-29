local addon = select(2, ...)

addon.classic.weakauras.config.primary = {
	name = 'Primary',
	groupConfig = {
		anchor = {
			type = 'SELECTFRAME',
			frame = 'AelUIPrimaryAnchor',
			from = 'TOP',
			to = 'TOP',
		},
		grow = {
			type = 'CUSTOM',
			on = 'changed',
			custom = 'function(newPositions, activeRegions) AelUI.weakauras.growers.primary(newPositions, activeRegions) end',
		},
	},
	createIcon = function(id, class, aura)
		local icon = LibWA.CreateIcon(id)
		icon.display:SetSize(40, 40)

		icon.display:SetCooldown({ inverse = true })

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

		local trigger = icon.triggers:AddSpellCooldown(aura.spellId, {
			show = 'always',
		})

		local cond = icon.conditions:Add()
		cond:CheckOnCooldown(trigger, true)
		cond:ChangeColor({ 1, 1, 1, 0.5 })
		cond:ChangeDesaturate(true)

		local cond = icon.conditions:Add()
		cond:CheckSpellInRange(trigger, false)
		cond:ChangeColor({ 1, 0, 0, 0.5 })
		cond:ChangeDesaturate(true)

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
