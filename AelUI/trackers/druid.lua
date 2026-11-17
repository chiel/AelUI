local _, ns = ...

local AelTrackers = LibStub('AelTrackers-1.0')
local h = ns.trackers.helpers
local m = ns.media

local _, playerClass = UnitClass('player')

if playerClass ~= 'DRUID' then
	return
end

local function createRejuv(t)
	local icon = t.display:Icon(64)
	icon:Color({ 1, 1, 1, 0.75 })
	icon:Desaturate(true)

	local auraIcon = t.display:AuraIcon(64)
	auraIcon:Cooldown({ reverse = true })

	local border = t.display:Border()
	border:Color({ 0, 0, 0 })

	local progress = t.display:AuraProgressText()
	progress:Point('BOTTOM', 0, -2)

	local spell = t.sources:Spell(774, { icon = icon })
	local cd = t.sources:Aura('target', 'buff', 774, {
		elements = { auraIcon, progress },
		ownOnly = true,
	})

	local effect = t.effects:Add()
	effect:CheckInRange(spell, false)
	effect:ChangeColor(border, { 1, 0, 0, 1 })
end

local primary = AelTrackers.createGroup(function(g)
	g:Layout('horizontal', 'start', 2)
	g:Tracker(h.createSpellIcon(740)) -- Tranquility
	g:Tracker(h.createSpellIcon(102342)) -- Ironbark
	g:Tracker(h.createSpellIcon(33891)) -- Incarnation: Tree of Life
	g:Tracker(h.createSpellIcon(18562)) -- Swiftmend
	g:Tracker(h.createSpellIcon(132158)) -- Nature's Swiftness
	g:Tracker(h.createSpellIcon(48438)) -- Wild Growth
	g:Tracker(createRejuv)
	g:Tracker(function(t)
		local icon = t.display:Icon(64)
		icon:Cooldown()

		local border = t.display:Border()
		border:Color({ 0, 0, 0 })

		local progress = t.display:Text()
		progress:Point('BOTTOM', 0, -2)

		local count = t.display:Text({ font = { size = 14 } })
		count:Point('TOPRIGHT', 0, -2)

		local item = t.sources:Item(191383, {
			count = count,
			durations = { icon, progress },
			icon = icon,
		})

		local effect = t.effects:Add()
		effect:CheckOnCooldown(item, true)
		effect:ChangeColor(icon, { 1, 1, 1, 0.75 })
		effect:ChangeDesaturate(icon, true)
	end)
end)

primary:SetPoint('TOP', AelUIPrimaryAnchor, 'TOP', 0, 0)
primary:Watch(function(width, height)
	ns.anchors.primary:UpdateWidth(width)
end)

local secondary = AelTrackers.createGroup(function(g)
	g:Tracker(h.createSpellIcon(102793, 44)) -- Ursol's Vortex
	g:Tracker(h.createSpellIcon(1850, 44)) -- Dash
	g:Tracker(h.createSpellIcon(102401, 44)) -- Wild Charge
	g:Tracker(h.createSpellIcon(2908, 44)) -- Soothe
	g:Tracker(h.createSpellIcon(22812, 44)) -- Barkskin
	g:Tracker(h.createSpellIcon(22842, 44)) -- Frenzied Regeneration
	g:Tracker(h.createSpellIcon(1261867, 44)) -- Heart of the Wild
	g:Tracker(h.createSpellIcon(106898, 44)) -- Stampeding Roar
	g:Tracker(h.createSpellIcon(6795, 44)) -- Growl
	g:Tracker(h.createSpellIcon(88423, 44)) -- Nature's Cure
end)

secondary:SetPoint('TOP', AelUISecondaryAnchor, 'TOP', 0, 0)
secondary:Watch(function(width, height)
	ns.anchors.secondary:UpdateWidth(width)
end)
