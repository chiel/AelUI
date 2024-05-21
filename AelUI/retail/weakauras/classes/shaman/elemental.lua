local ns = select(2, ...)

local wa = ns.weakauras
local auraIcon = wa.createAuraIconBuilder
local consumableIcon = wa.createConsumableIconBuilder
local itemIcon = wa.createItemIconBuilder
local spellIcon = wa.createSpellIconBuilder
local consumables = wa.consumables
local racials = wa.racials
local spells = wa.classes.shaman.spells

table.insert(ns.weakauras.classes.shaman.specs, {
	specId = 262, -- Elemental

	groups = {
		primary = {
			racials.bloodFury,
			spellIcon(191634, function(icon) -- Stormkeeper
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				local trigger = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 191634 },
					ownOnly = true,
				})
				icon.triggers:SetDisjunctive('any')
				icon.triggers:Move(trigger, 1)

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(trigger, true)
				cond:ChangeColor({ 1, 1, 1, 1 })
				cond:ChangeDesaturate(false)
				cond:ChangeInverse(false)
				cond:ChangeGlowVisibility(glow, true)
			end),
			spellIcon(114050), -- Ascendance
			spellIcon(198067), -- Fire Elemental
			spellIcon(192249), -- Storm Elemental
			spellIcon(210714), -- Icefury
			spells.primordialWave,
			spells.elementalBlast,
			spells.lavaBurst,
			spellIcon(192222), -- Liquid Magma Totem
			spells.flameShock,
			spells.naturesSwiftness,
			spells.totemicRecall,
		},
		secondary = {
			spells.windShear,
			spells.capacitorTotem,
			spells.earthbindTotem,
			spells.earthgrabTotem,
			spells.hex,
			spells.lightningLasso,
			spells.thunderstorm,

			spells.gustOfWind,
			spells.spiritWalk,
			spells.spiritwalkersGrace,
			spells.windRushTotem,

			spells.purge,
			spells.greaterPurge,
			spells.cleanseSpirit,

			spells.poisonCleansingTotem,
			spells.tranquilAirTotem,
			spells.tremorTotem,

			spells.totemicProjection,
		},
		defensives = {
			spells.stoneskinTotem,
			spells.earthElemental,
			spells.ancestralGuidance,
			spells.healingStreamTotem,
			spells.astralShift,
		},
		tracking = {
			auraIcon('target', 'debuff', 188389),
		},
		-- consumables = {
		-- 	consumables.dreamwalkersHealingPotion,
		-- 	consumables.healthstone,
		-- 	consumables.elementalPotionOfUltimatePower,
		-- 	consumables.potionOfShockingDisclosure,
		-- 	consumables.potionOfTheHushedZephyr,
		-- },
	},
})
