local _, ns = ...

local wa = ns.weakauras
local c = wa.creators
local h = wa.helpers

local function addSpellRangeBorderColor(spellId)
	return function(icon)
		icon.triggers:SetActivateOn('any')

		local border = icon.display:Get(2)
		local spell = icon.triggers:AddSpellCooldown(spellId, { show = 'always' })
		local cond = icon.conditions:Add()
		cond:CheckSpellInRange(spell, false)
		cond:ChangeBorderColor(border, { 1, 0, 0, 0.75 })
	end
end

ns.weakauras.data.classes.warlock = {
	name = 'Warlock',
	icon = 626007,
	id = 'WARLOCK',

	groups = {
		primary = {
			c.composeAura(
				c.auraIcon('target', 'debuff', { 348, 707 }), -- Immolate
				addSpellRangeBorderColor(348)
			),
			c.composeAura(
				c.auraIcon('target', 'debuff', 172), -- Corruption
				addSpellRangeBorderColor(172)
			),
			c.composeAura(
				c.auraIcon('target', 'debuff', 980), -- Corruption
				addSpellRangeBorderColor(980)
			),
		},
		secondary = {
			c.spellIcon(7744), -- Will of the Forsaken
		},
		reminders = {
			c.composeAura(
				c.auraIcon('player', 'buff', { 687, 696 }), -- Demon Skin
				function(icon)
					icon.triggers:Delete(2)
					local buff = icon.triggers:Get(1)
					buff:SetShow('onMissing')
				end
			),
		},
	},
}
