local _, ns = ...

local AelTrackers = LibStub('AelTrackers-1.0')
local m = ns.media

local _, playerClass = UnitClass('player')

if playerClass ~= 'DRUID' then
	return
end

local tranq = AelTrackers.createTracker(function(t)
	local icon = t.display:Icon(58)
	icon:Cooldown()

	local border = t.display:Border()
	border:Color({ 0, 0, 0 })

	local progress = t.display:Text()
	progress:Point('BOTTOM', 0, -2)

	local cd = t.triggers:SpellCooldown(740, {
		durations = { icon, progress },
		icon = icon,
	})

	local cond = t.conditions:Add()
	cond:CheckOnCooldown(cd, true)
	cond:ChangeColor(icon, { 1, 1, 1, 0.75 })
	cond:ChangeDesaturate(icon, true)
end)

local wildGrowth = AelTrackers.createTracker(function(t)
	local icon = t.display:Icon(58)
	icon:Cooldown()

	local border = t.display:Border()
	border:Color({ 0, 0, 0 })

	local progress = t.display:Text()
	progress:Point('BOTTOM', 0, -2)

	local cd = t.triggers:SpellCooldown(48438, {
		durations = { icon, progress },
		icon = icon,
	})

	local cond = t.conditions:Add()
	cond:CheckOnCooldown(cd, true)
	cond:ChangeColor(icon, { 1, 1, 1, 0.75 })
	cond:ChangeDesaturate(icon, true)
end)

local rejuv = AelTrackers.createTracker(function(t)
	local icon = t.display:Icon(58)
	icon:Color({ 1, 1, 1, 0.75 })
	icon:Desaturate(true)

	local auraIcon = t.display:AuraIcon(58)
	auraIcon:Cooldown({ reverse = true })

	local border = t.display:Border()
	border:Color({ 0, 0, 0 })

	local progress = t.display:AuraText()
	progress:Point('BOTTOM', 0, -2)

	local spell = t.triggers:Spell(774, { icon = icon })
	local cd = t.triggers:Aura('target', 'buff', 774, {
		elements = { auraIcon, progress },
		ownOnly = true,
	})

	local cond = t.conditions:Add()
	cond:CheckInRange(spell, false)
	cond:ChangeColor(border, { 1, 0, 0, 1 })
end)

tranq:SetPoint('TOPLEFT', AelUIPrimaryAnchor, 'TOPLEFT', 0, 0)
wildGrowth:SetPoint('TOPLEFT', tranq, 'TOPRIGHT', 2, 0)
rejuv:SetPoint('TOPLEFT', wildGrowth, 'TOPRIGHT', 2, 0)
