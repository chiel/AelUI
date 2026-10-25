local AelTrackers = LibStub('AelTrackers-1.0')

local _, playerClass = UnitClass('player')

if playerClass ~= 'WARLOCK' then
	return
end

local wotf = AelTrackers.createTracker(function(t)
	local icon = t.display:Icon(42, 42)
	icon:Cooldown()

	local border = t.display:Border()
	border:Color({ 0, 0, 0 })

	local progress = t.display:Text()
	progress:Point('BOTTOM', 0, -2)

	local spell = t.sources:Spell(7744, {
		durations = { icon, progress },
		icon = icon,
	})

	local effect = t.effects:Add()
	effect:CheckOnCooldown(spell, true)
	effect:ChangeColor(icon, { 1, 1, 1, 0.75 })
	effect:ChangeDesaturate(icon, true)
end)

wotf:SetPoint('TOP', AelUISecondaryAnchor, 'TOP', 0, 0)
