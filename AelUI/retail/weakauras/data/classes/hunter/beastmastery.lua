local _, ns = ...

local wa = ns.weakauras
local reminderIcon = wa.reminderIcon
local spellIcon = wa.spellIcon
local spells = wa.data.classes.hunter.spells

table.insert(ns.weakauras.data.classes.hunter.specs, {
	specId = 253, -- Beast Mastery

	groups = {
		primary = {
			spellIcon(19574), -- Bestial Wrath
			spellIcon(359844), -- Call of the Wild
			spellIcon(462031), -- Implosive Trap
			spellIcon(120679), -- Dire Beast
			spellIcon(53351, function(icon) -- Kill Shot
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local trigger = icon.triggers:AddSpellActivationOverlay(53351)

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(trigger, true)
				cond:ChangeGlowVisibility(glow, true)
				icon.conditions:Move(cond, 1)

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(trigger, false)
				cond:ChangeColor({ 1, 1, 1, 0.75 })
				cond:ChangeDesaturate(true)
				icon.conditions:Move(cond, 2)
			end),
			spellIcon(34026), -- Kill Command
			spellIcon(212431), -- Explosive Shot
			spellIcon(217200), -- Barbed Shot
			spellIcon(193455), -- Cobra Shot
			spellIcon(2643), -- Multi Shot
		},
		secondary = {
			spellIcon(147362), -- Counter Shot
			spellIcon(19577), -- Intimidation
			spellIcon(186387), -- Bursting Shot
			spellIcon(187650), -- Freezing Trap
			spellIcon(109248), -- Binding Shot
			spellIcon(187698), -- Tar Trap

			spellIcon(5384), -- Feign Death
			spellIcon(1543), -- Flare
			spellIcon(34477), -- Misdirection
			spellIcon(19801), -- Tranquilizing Shot

			spellIcon(186257), -- Aspect of the Cheetah
			spellIcon(781), -- Disengage
		},
		defensives = {
			spellIcon(186265), -- Aspect of the Turtle
			spellIcon(109304), -- Exhilaration
			spellIcon(264735), -- Survival of the Fittest
		},
	},
})
