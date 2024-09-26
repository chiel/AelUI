local _, ns = ...

local wa = ns.weakauras
local spellIcon = wa.spellIcon
local spells = wa.data.classes.shaman.spells

table.insert(ns.weakauras.data.classes.shaman.specs, {
	specId = 262, -- Elemental

	groups = {
		primary = {
			spellIcon(114050), -- Ascendance
			spellIcon(198067), -- Fire Elemental
			spellIcon(191634, function(icon) -- Stormkeeper
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local trigger = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 191634 },
					ownOnly = true,
				})
				icon.triggers:Move(trigger, 1)

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(trigger, true)
				cond:ChangeColor({ 1, 1, 1, 1 })
				cond:ChangeDesaturate(false)
				cond:ChangeInverse(false)
				cond:ChangeGlowVisibility(glow, true)
			end),
			spellIcon(192249), -- Storm Elemental
			spellIcon(375982), -- Primordial Wave
			spells.lavaBurst,
			spellIcon(192222), -- Liquid Magma Totem
			spells.flameShock,
			spells.naturesSwiftness,
			spells.totemicRecall,
			spells.frostShock,
		},
		secondary = {
			spells.windShear,
			spells.lightningLasso,
			spells.capacitorTotem,
			spells.thunderstorm,
			spells.earthbindTotem,
			spells.earthgrabTotem,
			spells.hex,

			spells.cleanseSpirit,
			spells.greaterPurge,
			spells.purge,
			spells.poisonCleansingTotem,
			spells.tremorTotem,

			spells.gustOfWind,
			spells.spiritWalk,
			spells.spiritwalkersGrace,
			spells.windRushTotem,

			spells.totemicProjection,
		},
		defensives = {
			spells.stoneBulwarkTotem,
			spells.healingStreamTotem,
			spells.earthElemental,
			spells.ancestralGuidance,
			spells.astralShift,
		},
		tracking = {},
	},
})
