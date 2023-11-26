local addon = select(2, ...)

local u = addon.weakauras.utils

addon.weakauras.utils.buildSpellIconAura = function(data, groupType)
	local glow = data.glow

	local aura = u.buildIconAura({
		groupType = groupType,
		showGlow = glow ~= nil,
	})

	aura.triggers = {
		disjunctive = 'any',
	}

	local spellTriggerIndex = 1
	if data.buffId ~= nil then
		spellTriggerIndex = 2
		aura.triggers[1] = {
			trigger = {
				type = 'aura2',
				unit = 'player',
				debuffType = 'HELPFUL',
				auraspellids = { data.buffId },
				useExactSpellId = true,
				ownOnly = true,
			},
		}
	end

	aura.triggers[spellTriggerIndex] = {
		trigger = {
			type = 'spell',
			event = 'Cooldown Progress (Spell)',
			spellName = data.spellId,
			genericShowOn = 'showAlways',
		},
	}

	aura.conditions = {
		{
			check = {
				trigger = -2,
				variable = 'AND',
				checks = { -- ability on cd
					{
						trigger = spellTriggerIndex,
						variable = 'charges',
						op = '==',
						value = '0',
					},
				},
			},
			changes = {
				{
					property = 'color',
					value = { 1, 1, 1, 0.75 },
				},
				{
					property = 'desaturate',
					value = true,
				},
			},
		},
		{ -- ability out of range
			check = {
				trigger = spellTriggerIndex,
				variable = 'spellInRange',
				value = 0,
			},
			changes = {
				{
					property = 'color',
					value = { 0.8, 0.18, 0.18, 0.75 },
				},
				{
					property = 'desaturate',
					value = true,
				},
			},
		},
	}

	if data.buffId ~= nil then
		table.insert(aura.conditions[1].check.checks, {
			trigger = 1,
			variable = 'show',
			value = 0,
		})

		table.insert(aura.conditions, {
			check = {
				trigger = 1,
				variable = 'show',
				value = 1,
			},
			changes = {
				{
					property = 'inverse',
				},
			},
		})
	end

	if glow ~= nil then
		local check = {
			trigger = spellTriggerIndex + 1,
			variable = 'show',
			value = glow.missing and 0 or 1,
		}

		local changes = {
			{
				property = 'sub.2.glow',
				value = true,
			},
		}

		if glow.type == 'buff' then
			local auraIds = {}
			for _, auraId in ipairs(glow.auraIds) do
				table.insert(auraIds, tostring(auraId))
			end

			aura.triggers[spellTriggerIndex + 1] = {
				trigger = {
					type = 'aura2',
					unit = glow.unit or 'player',
					debuffType = 'HELPFUL',
					auraspellids = auraIds,
					useExactSpellId = true,
					ownOnly = true,
				},
			}

			if glow.unit == 'group' then
				check.variable = 'unitCount'
				check.op = glow.missing and '==' or '>'
				check.value = '0'
			end

			if glow.stacks ~= nil then
				check = {
					trigger = spellTriggerIndex + 1,
					variable = 'stacks',
					op = '>=',
					value = tostring(glow.stacks),
				}
			end
		end

		if glow.type == 'overlay' then
			aura.triggers[spellTriggerIndex + 1] = {
				trigger = {
					type = 'spell',
					event = 'Spell Activation Overlay',
					spellName = data.spellId,
				},
			}
		end

		table.insert(aura.conditions, {
			check = check,
			changes = changes,
		})
	end

	if data.customConfig ~= nil then
		aura = data.customConfig(aura)
	end

	return aura
end
