local _, ns = ...

local wa = ns.weakauras
local spellIcon = wa.spellIcon
local spells = wa.data.classes.deathknight.spells

table.insert(wa.data.classes.deathknight.specs, {
	specId = 252, -- Unholy

	groups = {
		primary = {
			spells.abominationLimb,
			spellIcon(42650), -- Army of the Dead / Raise Abomination
			spellIcon(49206), -- Summon Gargoyle
			spellIcon(207289), -- Unholy Assault
			spellIcon(63560), -- Dark Transformation
			spellIcon(275699), -- Apocalypse
			spellIcon(390279), -- Vile Contagion
			spellIcon(152280), -- Defile

			-- spellIcon(207317), -- Epidemic
			-- spellIcon(77575), -- Outbreak
			-- spellIcon(85948), -- Festering Strike
			-- spellIcon(55090), -- Scourge Strike
			-- spellIcon(46584), -- Raise Dead
			-- spellIcon(207311), -- Clawing Shadows

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
		},
		defensives = {
			spells.sacrificialPact,
			spells.antiMagicZone,
			spells.antiMagicShell,
			spells.deathPact,
			spells.lichborne,
			spells.iceboundFortitude,
		},
		tracking = {
			-- 194310 -- Festering Wound
		},
	},
})
