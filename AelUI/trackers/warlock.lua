local _, ns = ...

local AelTrackers = LibStub('AelTrackers-1.0')

local h = ns.trackers.helpers

local _, playerClass = UnitClass('player')

if playerClass ~= 'WARLOCK' then
	return
end

local primary = AelTrackers.createGroup(function(g)
	g:Tracker(function(t)
		local icon = t.display:Icon(64)
		icon:Color({ 1, 1, 1, 0.75 })
		icon:Desaturate(true)

		local border = t.display:Border()
		border:Color({ 0, 0, 0 })

		local spell = t.sources:Spell(5019, { icon = icon })

		local effect = t.effects:Add()
		effect:CheckInRange(spell, false)
		effect:ChangeColor(border, { 1, 0, 0, 1 })

		local effect = t.effects:Add()
		effect:CheckAutoRepeating(spell, true)
		effect:ChangeColor(icon, { 1, 1, 1, 1 })
		effect:ChangeDesaturate(icon, false)
	end)

	g:Tracker(h.createAuraIcon('target', 'debuff', {
		-- Curse of Weakness
		702,
		1108,
		6205,
		7646,
		11707,
		11708,
		-- Curse of Recklessness
		704,
		7658,
		7659,
		11717,
		-- Curse of Elements
		440892,
		1311676,
		1311677,
		1311680,
		-- Curse of Tongues
		1714,
		11719,
	}))

	g:Tracker(h.createAuraIcon('target', 'debuff', { 1293695, 1293696 })) -- Demonic Brand
	g:Tracker(h.createAuraIcon('target', 'debuff', { 18265, 18879 })) -- Siphon Life
	g:Tracker(h.createAuraIcon('target', 'debuff', { 980, 1014, 6217, 11711, 11712, 11713 })) -- Bane of Agony
	g:Tracker(h.createAuraIcon('target', 'debuff', { 172, 6222, 6223, 7648, 11671, 11672 })) -- Corruption
	g:Tracker(h.createAuraIcon('target', 'debuff', { 348, 707, 1094, 2941, 11665, 11667, 11668 })) -- Immolate
	g:Tracker(h.createSpellIcon(689)) -- Drain Life
	g:Tracker(h.createSpellProcIcon(686, { 17941 })) -- Shadow Bolt
end)

primary:SetPoint('TOP', AelUIPrimaryAnchor, 'TOP', 0, 0)
primary:Watch(function(width, height)
	ns.anchors.primary:UpdateWidth(width)
end)

local secondary = AelTrackers.createGroup(function(g)
	g:Tracker(h.createSpellIcon(18708, 44)) -- Fel Domination
	g:Tracker(h.createSpellIcon(6353, 44)) -- Soul Fire
	g:Tracker(h.createSpellIcon(603, 44)) -- Bane of Doom
	g:Tracker(h.createSpellIcon(6789, 44)) -- Death Coil
	g:Tracker(h.createSpellIcon(5782, 44)) -- Fear
	g:Tracker(h.createSpellIcon(5484, 44)) -- Howl of Terror
	g:Tracker(h.createSpellIcon(6229, 44)) -- Shadow Ward
	g:Tracker(h.createSpellIcon(7744, 44)) -- Will of the Forsaken
	g:Tracker(h.createSpellIcon(20577, 44)) -- Cannibalism
end)

secondary:SetPoint('TOP', AelUISecondaryAnchor, 'TOP', 0, 0)
secondary:Watch(function(width, height)
	ns.anchors.secondary:UpdateWidth(width)
end)
