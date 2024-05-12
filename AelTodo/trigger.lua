local addon = select(2, ...)

local cache = {}

AelTodo.Trigger = function(allstates, event, ...)
	if event == 'AEL_TODO_UPDATE' then
		local key, plugin = ...
		cache[key] = plugin
	end

	local pluginsByPriority = {}
	for key, plugin in pairs(cache) do
		local priority = plugin.priority or 'LOW'
		if pluginsByPriority[priority] == nil then
			pluginsByPriority[priority] = {}
		end
		table.insert(pluginsByPriority[priority], key)
	end

	local pluginOrder = {}
	for _, priority in ipairs(addon.config.priorityOrder) do
		if pluginsByPriority[priority] ~= nil then
			for _, key in ipairs(pluginsByPriority[priority]) do
				table.insert(pluginOrder, key)
			end
		end
	end

	-- hide all state to avoid weird display issues
	for key, state in pairs(allstates) do
		allstates[key] = Mixin(state, { changed = true, show = false })
	end

	local i = 1
	for _, key in ipairs(pluginOrder) do
		local plugin = cache[key]
		for _, section in ipairs(plugin.sections) do
			local showSection = false
			local addStates = {}

			if addon.config.empty_line_between_sections and i > 1 then
				table.insert(addStates, {
					key = 'spacing' .. i,
					value = {
						changed = true,
						show = true,
						name = '',
					},
				})
			end

			table.insert(addStates, {
				key = 'heading_' .. key .. '_' .. section.name,
				value = {
					changed = true,
					show = true,
					name = WrapTextInColorCode(section.name, addon.config.colors.heading),
				},
			})

			for _, entry in ipairs(section.entries) do
				local state = entry.state or 'PENDING'
				local showEntry = (
					state == 'PENDING'
					or (state == 'COMPLETED' and addon.config.show_completed)
					or (state == 'UNAVAILABLE' and addon.config.show_unavailable)
				)

				if showEntry then
					local line = WrapTextInColorCode(entry.name, addon.config.stateColors[state])
					local note = entry.note
					if entry.coords ~= nil then
						if note ~= nil then
							note = note .. ' - ' .. entry.coords
						else
							note = entry.coords
						end
					end

					if note ~= nil then
						line = line .. WrapTextInColorCode(' (' .. note .. ')', addon.config.colors.note)
					end

					showSection = true
					table.insert(addStates, {
						key = 'entry_' .. key .. '_' .. section.name .. '_' .. entry.name,
						value = {
							changed = true,
							show = true,
							name = line,
						},
					})
				end
			end

			if showSection then
				for _, state in ipairs(addStates) do
					allstates[state.key] = Mixin({}, state.value, { index = i })
					i = i + 1
				end
			end
		end
	end

	return true
end
