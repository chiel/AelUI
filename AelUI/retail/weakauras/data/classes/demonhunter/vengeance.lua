local _, ns = ...

local wa = ns.weakauras
local reminderIcon = wa.reminderIcon
local spellIcon = wa.spellIcon
local spells = wa.data.classes.demonhunter.spells

table.insert(ns.weakauras.data.classes.demonhunter.specs, {
	specId = 581, -- Vengeance

	groups = {
		primary = {
			spellIcon(187827), -- Metamorphosis
			spellIcon(232893), -- Felblade
			spellIcon(258920), -- Immolation Aura
			spellIcon(204157), -- Throw Glaive
			spellIcon(203720), -- Demon Spikes
			spellIcon(212084), -- Fel Devastation
			spellIcon(263642), -- Fracture
			spellIcon(204596), -- Sigil of Flame
			spellIcon(228477), -- Soul Cleave
			spellIcon(247454), -- Spirit Bomb
		},
		secondary = {
			spellIcon(179057), -- Chaos Nova
			spellIcon(183752), -- Disrupt
			spellIcon(217832), -- Imprison
			spellIcon(207684), -- Sigil of Misery
			spellIcon(188501), -- Spectral Sight
			spellIcon(185245), -- Torment
			spellIcon(198793), -- Vengeful Retreat
			spellIcon(189110), -- Infernal Strike
			spellIcon(202138), -- Sigil of Chains
			spellIcon(202137), -- Sigil of Silence
		},
		defensives = {
			spellIcon(196718), -- Darkness
			spellIcon(204021), -- Fiery Brand
		},
	},
})
