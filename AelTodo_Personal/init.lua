local addon = select(2, ...)

addon.sections = {}

AelTodo.RegisterPlugin({
	name = 'personal',
	priority = 'MEDIUM',
	events = {
		'ACHIEVEMENT_EARNED',
		'PLAYER_ENTERING_WORLD',
		'QUEST_TURNED_IN',
	},
	handler = function()
		local sections = {}

		for _, section in ipairs(addon.sections) do
			local entries = AelTodo.ProcessEntries(section.entries)
			if #entries > 0 then
				table.insert(sections, { name = section.name, entries = entries })
			end
		end

		return sections
	end,
})
