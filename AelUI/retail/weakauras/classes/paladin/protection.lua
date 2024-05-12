local ns = select(2, ...)

local wa = ns.weakauras
local auraIcon = wa.createAuraIconBuilder
local itemIcon = wa.createItemIconBuilder
local spellIcon = wa.createSpellIconBuilder
local consumables = wa.consumables
local spells = wa.classes.paladin.spells

table.insert(ns.weakauras.classes.paladin.specs, {
	name = 'Protection',
	icon = 236264,
	specId = 66,

	groups = {
		primary = {
			spells.avengingWrath,
			spellIcon(387174), -- Eye of Tyr
			spells.divineToll,
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
		consumables = {
			consumables.dreamwalkersHealingPotion,
			consumables.healthstone,
			consumables.elementalPotionOfUltimatePower,
			consumables.potionOfTheHushedZephyr,
		},
		tracking = {
			auraIcon('buff', 132403), -- Shield of the Righteous
			auraIcon('buff', 327510, function(icon) -- Shining Light
				icon.display:SetIcon(133192)
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')

				local trigger1 = icon.triggers:Get(1)
				trigger1:SetShow('onActive')

				local trigger2 = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 182104 },
					show = 'always',
				})

				local text2 = icon.display:GetSubRegion(5)

				local cond = icon.conditions:Get(1)
				cond:CheckTriggerActive(trigger1, false)

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(trigger1, true)
				cond:ChangeGlowVisibility(glow, true)
				cond:ChangeTextVisibility(text2, false)
			end),
		},
	},
})
