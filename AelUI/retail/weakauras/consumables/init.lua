local ns = select(2, ...)

local m = ns.media
local wa = ns.weakauras
local consumableIcon = wa.createConsumableIconBuilder

ns.weakauras.consumables = {
	dreamwalkersHealingPotion = consumableIcon(207023),
	elementalPotionOfUltimatePower = consumableIcon(191383),
	potionOfTheHushedZephyr = consumableIcon(191395),
	potionOfShockingDisclosure = consumableIcon(191401),

	healthstone = function(idPrefix, config)
		local itemId = 5512
		local id = idPrefix .. ' - Healthstone'
		local icon = wa.createIcon(id, config)

		local glow = icon.display:AddGlow('proc', { startAnimation = true })
		icon.display:Move(glow, 3)

		icon.display:AddText('%3.s', {
			font = m.fonts.bold.name,
			size = 12,
			justify = 'RIGHT',
			anchor = {
				from = 'TOPRIGHT',
				to = 'TOPRIGHT',
				y = -1,
			},
		})

		icon.triggers:SetDisjunctive('custom', 'function(t) return t[3] or t[1] or t[4] end')
		local itemCooldown1 = icon.triggers:AddItemCooldown(itemId, { show = 'onCooldown' })
		local itemCooldown2 = icon.triggers:AddItemCooldown(itemId, { show = 'onReady' })
		local itemCount = icon.triggers:AddItemCount(itemId, { includeCharges = true, count = { '>', 0 } })
		local hasWarlock = icon.triggers:AddUnitCharacteristics({
			unit = 'group',
			character = 'player',
			class = 'WARLOCK',
			level = { { '>=', 47 } },
		})

		local cond = icon.conditions:Add()
		cond:CheckOnCooldown(itemCooldown1, true)
		cond:ChangeColor({ 1, 1, 1, 0.75 })
		cond:ChangeDesaturate(true)

		local cond = icon.conditions:Add()
		cond:CheckTriggerActive(itemCount, false)
		cond:ChangeColor({ 1, 1, 1, 0.75 })
		cond:ChangeDesaturate(true)
		cond:ChangeGlowVisibility(glow, true)

		return icon
	end,
}
