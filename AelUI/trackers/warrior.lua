local AelTrackers = LibStub('AelTrackers-1.0')

local _, playerClass = UnitClass('player')

if playerClass ~= 'WARRIOR' then
	return
end

-- local charge = AelTrackers.createTracker(function(t)
-- 	local icon = t.display:Icon(58, 58)
-- 	icon:Cooldown()

-- 	local border = t.display:Border()
-- 	border:Color({ 0, 0, 0 })

-- 	local progress = t.display:Text()
-- 	progress:Point('BOTTOM', 0, -2)

-- 	local spell = t.sources:Spell(100, {
-- 		durations = { icon, progress },
-- 		icon = icon,
-- 	})

-- 	local cond = t.conditions:Add()
-- 	cond:CheckOnCooldown(spell, true)
-- 	cond:ChangeColor(icon, { 1, 1, 1, 0.75 })
-- 	cond:ChangeDesaturate(icon, true)
-- end)

-- charge:SetPoint('TOPLEFT', AelUIPrimaryAnchor, 'TOPLEFT', 0, 0)
