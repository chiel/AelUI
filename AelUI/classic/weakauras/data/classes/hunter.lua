local _, ns = ...

local wa = ns.weakauras
local c = wa.creators
local h = wa.helpers

ns.weakauras.data.classes.hunter = {
	name = 'Hunter',
	icon = 626000,
	id = 'HUNTER',

	groups = {
		primary = {
			c.spellIcon(3045), -- Rapid Fire
			c.spellIcon(19574), -- Bestial Wrath
			c.spellIcon(14294), -- Volley
			c.composeAura(
				c.spellIconBase(75), -- Auto Shot
				function(icon)
					icon.display:SetColor({ 1, 1, 1, 0.75 })
					icon.display:SetDesaturate(true)
					local glow = icon.display:AddGlow('pixel', {
						color = { 1, 1, 1, 0.75 },
						length = 8,
						lines = 6,
						speed = 0.2,
						x = -1,
						y = -1,
					})

					icon.triggers:SetActivateOn('any')
					local t = icon.triggers:AddCustomStatus({
						events = 'START_AUTOREPEAT_SPELL STOP_AUTOREPEAT_SPELL',
						custom = 'function() return IsAutoRepeatSpell(75) end',
					})

					local cond = icon.conditions:Add()
					cond:CheckActive(t, true)
					cond:ChangeGlowVisibility(glow, true)
				end
			),
			c.composeAura(
				c.spellIcon(20903), -- Aimed Shot
				function(icon)
					local border = icon.display:Get(2)

					icon.triggers:SetActivateOn('any')
					local queuedAction = icon.triggers:AddSpellQueuedAction(20903)

					local cond = icon.conditions:Add()
					cond:CheckActive(queuedAction, true)
					cond:ChangeBorderColor(border, { 1, 1, 0, 1 })
				end
			),
			c.spellIcon(14289), -- Multi-Shot
			c.spellIcon(5116), -- Concussive Shot
			c.spellIcon(14266), -- Raptor Strike
			c.spellIcon(14271), -- Mongoose Bite
		},
		secondary = {
			c.spellIcon(19263), -- Deterrence
			c.spellIcon(19503), -- Scatter Shot
			c.spellIcon(19577), -- Intimidation
			c.spellIcon(5384), -- Feign Death
			c.spellIcon(13809), -- Frost Trap
			c.spellIcon(1543), -- Flare
			c.spellIcon(19801), -- Tranquilizing Shot
			c.spellIcon(14327), -- Scare Beast
			c.spellIcon(15632), -- Distracting Shot
			c.spellIcon(14273), -- Disengage
		},
		tracking = {
			c.auraIcon('target', 'debuff', 14325), -- Hunter's Mark
		},
	},
}
