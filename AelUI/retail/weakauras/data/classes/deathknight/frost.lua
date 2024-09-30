local _, ns = ...

local wa = ns.weakauras
local spellIcon = wa.spellIcon
local spells = wa.data.classes.deathknight.spells

table.insert(wa.data.classes.deathknight.specs, {
	specId = 251, -- Frost

	groups = {
		primary = {
			spells.abominationLimb,
			spellIcon(152279), -- Breath of Sindragosa
			spellIcon(279302), -- Frostwyrm's Fury
			spellIcon(47568), -- Empower Rune Weapon
			spellIcon(57330), -- Horn of Winter
			spellIcon(51271), -- Pillar of Frost
			spellIcon(439843), -- Reaper's Mark
			spellIcon(305392), -- Chill Streak
			spellIcon(207230), -- Frostscythe
			spellIcon(196770), -- Remorseless Winter
			spellIcon(49020, function(icon) -- Obliterate
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)
				local stacks = icon.display:GetSubRegion(5)
				stacks:SetText('%2.s')

				icon.triggers:SetDisjunctive('any')
				local trigger = icon.triggers:AddAura('player', 'buff', {
					exactSpellIds = { 51124 }, -- Killing Machine
				})

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(trigger, true)
				cond:ChangeGlowVisibility(glow, true)
			end),
			spellIcon(49184, function(icon) -- Howling Blast
				local glow = icon.display:AddGlow('proc', { startAnimation = true })
				icon.display:Move(glow, 3)

				icon.triggers:SetDisjunctive('any')
				local trigger = icon.triggers:AddSpellActivationOverlay(49184)

				local cond = icon.conditions:Add()
				cond:CheckTriggerActive(trigger, true)
				cond:ChangeGlowVisibility(glow, true)
			end),
			spells.soulReaper,
			spells.deathAndDecay,
		},
		secondary = {
			spells.mindFreeze,
			spells.asphyxiate,
			spells.blindingSleet,
			spells.deathGrip,
			spells.controlUndead,
			spells.darkCommand,
			spells.wraithWalk,
			spells.deathsAdvance,
			spells.deathStrike,
			spells.raiseDead,
		},
		defensives = {
			spells.sacrificialPact,
			spells.antiMagicZone,
			spells.antiMagicShell,
			spells.deathPact,
			spells.lichborne,
			spells.iceboundFortitude,
		},
	},
})
