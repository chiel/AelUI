local _, ns = ...

local wa = ns.weakauras
local spellIcon = wa.spellIcon
local spells = wa.data.classes.deathknight.spells

table.insert(wa.data.classes.deathknight.specs, {
	specId = 250, -- Blood

	groups = {
		primary = {
			spells.abominationLimb,
			spellIcon(49028), -- Dancing Rune Weapon
			spellIcon(219809), -- Tombstone
			spellIcon(194844), -- Bonestorm
			spellIcon(221699), -- Blood Tap
			spellIcon(206931), -- Blooddrinker
			spellIcon(274156), -- Consumption
			spellIcon(50842), -- Blood Boil
			spellIcon(206940), -- Mark of Blood
			spells.soulReaper,
			spells.deathAndDecay,
		},
		secondary = {
			spells.mindFreeze,
			spells.asphyxiate,
			spells.blindingSleet,
			spellIcon(108199), -- Gorefiend's Grasp
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
			spellIcon(55233), -- Vampiric Blood
			spellIcon(194679), -- Rune Tap
		},
	},
})
