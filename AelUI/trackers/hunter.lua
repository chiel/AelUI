local AelTrackers = LibStub('AelTrackers-1.0')

local _, playerClass = UnitClass('player')

if playerClass ~= 'HUNTER' then
	return
end

local raptorStrike = AelTrackers.createTracker(function(t)
	local icon = t.display:Icon(58, 58)
	icon:Cooldown({})

	local spell = t.triggers:SpellCooldown(2973)

	local cond = t.conditions:Add()
	cond:CheckOnCooldown(spell, true)
	cond:ChangeColor(icon, { 1, 1, 1, 0.75 })
	cond:ChangeDesaturate(icon, true)
end)

raptorStrike:SetPoint('TOPLEFT', AelUIPrimaryAnchor, 'TOPLEFT', 0, 0)
