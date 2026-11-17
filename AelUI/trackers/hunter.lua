local _, ns = ...

local AelTrackers = LibStub('AelTrackers-1.0')

local h = ns.trackers.helpers

local _, playerClass = UnitClass('player')

if playerClass ~= 'HUNTER' then
	return
end

local primary = AelTrackers.createGroup(function(g)
	g:Tracker(function(t)
		local icon = t.display:Icon(64)
		icon:Color({ 1, 1, 1, 0.75 })
		icon:Desaturate(true)

		local border = t.display:Border()
		border:Color({ 0, 0, 0 })

		local spell = t.sources:Spell(75, { icon = icon })

		local effect = t.effects:Add()
		effect:CheckInRange(spell, false)
		effect:ChangeColor(border, { 1, 0, 0, 1 })

		local effect = t.effects:Add()
		effect:CheckAutoRepeating(spell, true)
		effect:ChangeColor(icon, { 1, 1, 1, 1 })
		effect:ChangeDesaturate(icon, false)
	end)

	g:Tracker(h.createSpellIcon(2973)) -- Raptor Strike
end)

primary:SetPoint('TOP', AelUIPrimaryAnchor, 'TOP', 0, 0)
primary:Watch(function(width, height)
	ns.anchors.primary:UpdateWidth(width)
end)

local secondary = AelTrackers.createGroup(function(g)
	g:Tracker(h.createSpellIcon(1259799, 44)) -- Elune's Light
end)

secondary:SetPoint('TOP', AelUISecondaryAnchor, 'TOP', 0, 0)
secondary:Watch(function(width, height)
	ns.anchors.secondary:UpdateWidth(width)
end)
