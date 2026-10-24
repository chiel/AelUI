local AelTrackers = LibStub('AelTrackers-1.0')

local _, playerClass = UnitClass('player')

if playerClass ~= 'WARLOCK' then
	return
end

-- local function debuffTracker(spellIds)
-- 	return AelTrackers.createTracker(function(t)
-- 		local icon = t.display:Icon(58, 58)
-- 		icon:Color({ 1, 1, 1, 0.75 })
-- 		icon:Desaturate(true)

-- 		local border = t.display:Border()
-- 		border:Color({ 0, 0, 0, 1 })

-- 		local spell = t.triggers:Spell(spellIds[1])
-- 		local aura = t.triggers:Aura('target', 'debuff', spellIds, { ownOnly = true })

-- 		local cond = t.conditions:Add()
-- 		cond:CheckInRange(spell, false)
-- 		cond:ChangeColor(border, { 1, 0, 0, 1 })
-- 	end)
-- end

-- local siphonLife = debuffTracker({ 18265 })
-- local baneOfAgony = debuffTracker({ 6217 })
-- local corruption = debuffTracker({ 172, 6222, 6223 })
-- local immolate = debuffTracker({ 2941 })
-- local curses = debuffTracker({ 7658, 6205, 1311676, 1714 })

-- local drainLife = AelTrackers.createTracker(function(t)
-- 	local icon = t.display:Icon(58, 58)
-- 	icon:Color({ 1, 1, 1, 0.75 })
-- 	icon:Desaturate(true)

-- 	local border = t.display:Border()
-- 	border:Color({ 0, 0, 0, 1 })

-- 	local spell = t.triggers:Spell(689)

-- 	local cond = t.conditions:Add()
-- 	cond:CheckInRange(spell, false)
-- 	cond:ChangeColor(border, { 1, 0, 0, 1 })
-- end)

-- siphonLife:SetPoint('TOPLEFT', AelUIPrimaryAnchor, 'TOPLEFT', 0, 0)
-- baneOfAgony:SetPoint('TOPLEFT', siphonLife, 'TOPRIGHT', 2, 0)
-- corruption:SetPoint('TOPLEFT', baneOfAgony, 'TOPRIGHT', 2, 0)
-- immolate:SetPoint('TOPLEFT', corruption, 'TOPRIGHT', 2, 0)
-- curses:SetPoint('TOPLEFT', immolate, 'TOPRIGHT', 2, 0)
-- drainLife:SetPoint('TOPLEFT', curses, 'TOPRIGHT', 2, 0)

local wotf = AelTrackers.createTracker(function(t)
	local icon = t.display:Icon(42, 42)
	icon:Cooldown({})

	local spell = t.triggers:SpellCooldown(7744)

	local cond = t.conditions:Add()
	cond:CheckOnCooldown(spell, true)
	cond:ChangeColor(icon, { 1, 1, 1, 0.75 })
	cond:ChangeDesaturate(icon, true)
end)

wotf:SetPoint('TOP', AelUISecondaryAnchor, 'TOP', 0, 0)
