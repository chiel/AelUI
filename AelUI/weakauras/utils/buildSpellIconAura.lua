local addon = select(2, ...)

local u = addon.weakauras.utils

addon.weakauras.utils.buildSpellIconAura = function(data, groupType)
	local glow = data.glow

	local aura = u.buildIconAura {
		groupType = groupType,
		showGlow = glow ~= nil,
	}

	aura.triggers = {
		[1] = {
			trigger = {
				type = 'spell',
				event = 'Cooldown Progress (Spell)',
				spellName = data.spellId,
				genericShowOn = 'showAlways',
			},
		},
	}

	aura.conditions = {
		{ -- ability on cd
			check = {
				trigger = 1,
				variable = 'charges',
				op = '==',
				value = '0',
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
				trigger = 1,
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

	if glow ~= nil then
		local check = {
			trigger = 2,
			variable = 'show',
			value = 1,
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

			aura.triggers[2] = {
				trigger = {
					type = 'aura2',
					unit = 'player',
					debuffType = 'HELPFUL',
					auraspellids = auraIds,
					useExactSpellId = true,
				},
			}

			if glow.stacks ~= nil then
				check = {
					trigger = 2,
					variable = 'stacks',
					op = '>=',
					value = tostring(glow.stacks),
				}
			end
		end

		if glow.type == 'overlay' then
			aura.triggers[2] = {
				trigger = {
					type = 'spell',
					event = 'Spell Activation Overlay',
					spellName = data.spellId,
				},
			}
		end

		aura.triggers.disjunctive = 'any'

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
