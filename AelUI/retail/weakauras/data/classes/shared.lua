local _, ns = ...

local wa = ns.weakauras
local auraIcon = wa.auraIcon

ns.weakauras.data.shared = {
	tomeOfLightsDevotion = auraIcon('player', 'buff', 450720, function(icon)
		icon.display:SetColor({ 1, 1, 1, 0.75 })
		icon.display:SetDesaturate(true)

		local glow = icon.display:AddGlow('proc', { startAnimation = true })
		icon.display:Move(glow, 3)

		local radianceStacksText = icon.display:Get(5)
		radianceStacksText:SetText('%3.s')

		local resilienceStacksText = ns.weakauras.addStacksText(icon)
		resilienceStacksText:SetText('%4.s')

		icon.triggers:SetDisjunctive('any')

		local radiance = icon.triggers:Get(1)
		radiance:SetShow('onActive')

		local resilience = icon.triggers:AddAura('player', 'buff', {
			show = 'onActive',
			exactSpellIds = { 450706 },
			ownOnly = true,
		})

		local radianceStacks = icon.triggers:AddAura('player', 'buff', {
			exactSpellIds = { 450699 },
			ownOnly = true,
		})

		local resilienceStacks = icon.triggers:AddAura('player', 'buff', {
			exactSpellIds = { 450696 },
			ownOnly = true,
		})

		local radiant = icon.triggers:AddAura('player', 'buff', {
			exactSpellIds = { 443534 },
			ownOnly = true,
		})

		local trinketCooldown = icon.triggers:AddItemCooldown(219309, {
			show = 'onReady',
		})

		local cond = icon.conditions:Add()
		cond:CheckTriggerActive(radiant, true)
		cond:ChangeColor({ 1, 1, 1, 1 })
		cond:ChangeDesaturate(false)

		local cond = icon.conditions:Add()
		cond:CheckTriggerActive(trinketCooldown, true)
		cond:ChangeGlowVisibility(glow, true)

		local cond = icon.conditions:Add()
		cond:CheckTriggerActive(radiance, true)
		cond:ChangeGlowVisibility(glow, false)
	end),
}
