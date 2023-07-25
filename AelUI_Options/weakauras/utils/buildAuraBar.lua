local addon = select(2, ...)

local u = addon.weakauras.utils

addon.weakauras.utils.buildAuraBar = function(data, groupType)
	local aura = u.buildBarAura { showSpark = true }

	aura.barColor = {
		data.color[1] / 255,
		data.color[2] / 255,
		data.color[3] / 255,
		data.color[4],
	}

	aura.width = 200
	aura.height = 6

	aura.triggers = {
		[1] = {
			trigger = {
				type = 'aura2',
				unit = 'player',
				debuffType = 'HELPFUL',
				auraspellids = { tostring(data.auraId) },
				useExactSpellId = true,
				ownOnly = true,
			},
		},
	}

	if data.pandemic ~= nil then
		table.insert(aura.subRegions, {
			type = 'subtick',
			tick_visible = true,
			tick_placement_mode = 'AtValue',
			tick_placement = tostring(data.pandemic),
			automatic_length = false,
			tick_length = aura.height - 2,
			tick_color = { 1, 1, 1 },
			tick_thickness = 1,
		})
	end

	return aura
end
