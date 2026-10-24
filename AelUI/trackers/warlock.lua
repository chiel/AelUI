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

	local spell = t.triggers:Spell(7744, {
		durations = { icon, progress },
		icon = icon,
	})

	local cond = t.conditions:Add()
	cond:CheckOnCooldown(spell, true)
	cond:ChangeColor(icon, { 1, 1, 1, 0.75 })
	cond:ChangeDesaturate(icon, true)
end)

wotf:SetPoint('TOP', AelUISecondaryAnchor, 'TOP', 0, 0)
