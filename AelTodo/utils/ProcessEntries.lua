AelTodo.ProcessEntries = function(rawEntries)
	local entries = {}
	for _, entry in ipairs(rawEntries) do
		local state = 'UNAVAILABLE'
		if entry.isAvailable == nil or entry.isAvailable() then
			state = 'PENDING'
		end

		local progress = ''
		if entry.isCompleted then
			local completed, completedCount, totalCount = entry.isCompleted()
			if completed then
				state = 'COMPLETED'
			end

			if totalCount ~= nil and totalCount > 1 then
				progress = string.format(' (%d/%d)', completedCount, totalCount)
			end
		end

		table.insert(entries, {
			name = entry.name .. progress,
			state = state,
		})
	end

	return entries
end
