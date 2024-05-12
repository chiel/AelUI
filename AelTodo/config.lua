local addon = select(2, ...)

addon.config = {
	empty_line_between_sections = true,
	show_completed = false,
	show_unavailable = false,

	priorityOrder = { 'HIGH', 'MEDIUM', 'LOW' },
	colors = {},
}

local rawColors = {
	completed = { 15, 255, 0, 255 },
	heading = { 79, 193, 233, 255 },
	note = { 168, 168, 168, 255 },
	pending = { 255, 255, 255, 255 },
	unavailable = { 255, 0, 0, 255 },
}

for key, color in pairs(rawColors) do
	addon.config.colors[key] = CreateColorFromBytes(unpack(color)):GenerateHexColor()
end

addon.config.stateColors = {
	COMPLETED = addon.config.colors.completed,
	PENDING = addon.config.colors.pending,
	UNAVAILABLE = addon.config.colors.unavailable,
}
