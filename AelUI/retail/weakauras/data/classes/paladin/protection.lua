local _, ns = ...

local wa = ns.weakauras
local auraIcon = wa.auraIcon
local reminderIcon = wa.reminderIcon
local spellIcon = wa.spellIcon
local spells = wa.data.classes.paladin.spells

table.insert(ns.weakauras.data.classes.paladin.specs, {
	specId = 66, -- Protection

	groups = {
		primary = {
			spells.avengingWrath,
			spellIcon(387174), -- Eye of Tyr
			spells.divineToll,
			spellIcon(432459), -- Holy Bulwark
			spellIcon(26573), -- Consecration
			spells.hammerOfWrath,
			spells.judgment,
			spellIcon(35395), -- Crusader Strike
			spellIcon(31935), -- Avenger's Shield
		},
		secondary = {
			spells.rebuke,
			spells.hammerOfJustice,
			spells.blindingLight,
			spells.divineSteed,
			spells.handOfReckoning,
			spells.cleanseToxins,
			spells.blessingOfFreedom,
			spells.blessingOfProtection,
			spells.blessingOfSacrifice,
		},
		defensives = {
			spells.layOnHands,
			spells.divineShield,
			spellIcon(86659), -- Guardian of Ancient Kings
			spellIcon(31850), -- Ardent Defender
		},
		tracking = {
			auraIcon('player', 'buff', 132403, function(icon) -- Shield of the Righteous
				icon.display:SetColor({ 1, 1, 1, 0.75 })
				icon.display:SetDesaturate(true)

				local trigger = icon.triggers:Get(1)

				local cond = icon.conditions:Add()
				cond:CheckAuraFound(trigger, true)
				cond:ChangeColor({ 1, 1, 1, 1 })
				cond:ChangeDesaturate(false)
			end),
			-- auraIcon('player', 'buff', 327510, function(icon) -- Shining Light
			-- 	icon.display:SetIcon(133192)
			-- 	local glow = icon.display:AddGlow('proc', { startAnimation = true })
			-- 	icon.display:Move(glow, 3)

			-- 	icon.triggers:SetDisjunctive('any')

			-- 	local trigger1 = icon.triggers:Get(1)
			-- 	trigger1:SetShow('onActive')

			-- 	local trigger2 = icon.triggers:AddAura('player', 'buff', {
			-- 		exactSpellIds = { 182104 },
			-- 		show = 'always',
			-- 	})

			-- 	local text2 = icon.display:GetSubRegion(5)

			-- 	local cond = icon.conditions:Get(1)
			-- 	cond:CheckTriggerActive(trigger1, false)

			-- 	local cond = icon.conditions:Add()
			-- 	cond:CheckTriggerActive(trigger1, true)
			-- 	cond:ChangeGlowVisibility(glow, true)
			-- 	cond:ChangeTextVisibility(text2, false)
			-- end),
		},
	},
})
