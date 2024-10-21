local _, ns = ...

local wa = ns.weakauras
local reminderIcon = wa.reminderIcon
local spellIcon = wa.spellIcon
local spells = wa.data.classes.druid.spells

table.insert(ns.weakauras.data.classes.druid.specs, {
	specId = 103, -- Feral

	groups = {
		primary = {
			spellIcon(106951), -- Berserk
			spellIcon(391528), -- Convoke the Spirits
			spellIcon(274837), -- Feral Frenzy
			spellIcon(5217), -- Tiger's Fury
			spellIcon(391888), -- Adaptive Swarm
			spellIcon(202028), -- Brutal Slash
			-- spellIcon(285381), -- Primal Wrath
			spellIcon(22568, function(icon) -- Ferocious Bite
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local trigger = icon.triggers:AddSpellActivationOverlay(22568)

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(trigger, true)
				cond:ChangeGlowVisibility(glow, true)
				-- 391882 -- Apex Predator's Craving
			end),
		},
		secondary = {
			spellIcon(106839), -- Skull Bash
			spellIcon(132469), -- Typhoon
			spellIcon(102793), -- Ursol's Vortex
			spellIcon(99), -- Incapacitating Roar

			spellIcon(127757), -- Charm Woodland Creature

			spellIcon(1850), -- Dash
			spellIcon(102401), -- Wild Charge
			spellIcon(106898), -- Stampeding Roar

			spellIcon(6795), -- Growl
			spellIcon(29166), -- Innervate
			spellIcon(2908), -- Soothe
			spellIcon(48438), -- Wild Growth
		},
		defensives = {
			spellIcon(22842), -- Frenzied Regeneration
			spellIcon(124974), -- Nature's Vigil
			spellIcon(108238), -- Renewal
			spellIcon(61336), -- Survival Instincts
			spellIcon(22812), -- Barkskin
		},
		reminders = {
			reminderIcon(1126), -- Mark of the Wild
		},
	},
})
