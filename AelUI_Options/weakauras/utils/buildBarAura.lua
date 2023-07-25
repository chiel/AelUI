local addon = select(2, ...)

local c = addon.weakauras.config

addon.weakauras.utils.buildBarAura = function(options)
	local options = options or {}
	local showSpark = options.showSpark or false

	local aura = {
		regionType = 'aurabar',
		texture = 'AelUI bar',

		subRegions = {
			{
				type = 'subbackground',
			},
			{
				type = 'subforeground',
			},
			{
				border_offset = 0,
				border_anchor = 'bar',
				type = 'subborder',
				border_color = { 0, 0, 0, 1 },
				border_visible = true,
				border_edge = 'AelUI border',
				border_size = 1,
			},
		},
	}

	if showSpark then
		aura.spark = true
		aura.sparkWidth = 10
		aura.sparkHeight = 10
	end

	return aura
end
